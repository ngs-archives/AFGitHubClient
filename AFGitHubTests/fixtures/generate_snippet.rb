#!/usr/bin/env ruby

require 'json'
require 'active_support/inflector/methods'
require 'active_support/inflector/transliterate'

filename = ARGV[0]
file     = IO.read(filename)
json     = JSON.load(file) or raise 'Not a JSON file.'
klass    = ActiveSupport::Inflector.camelize(filename.sub(/^([a-z_]+)\.json$/, '\1'), true)

TYPE_INTEGER = "NSInteger "
TYPE_BOOL    = "BOOL "
TYPE_USER    = "AFGitHubUser *"
TYPE_DICT    = "NSDictionary *"
TYPE_URL     = "NSURL *"
TYPE_STRING  = "NSString *"
TYPE_DATE    = "NSDate *"

RESERVED     = %w{id description}
USER_KEYS    = %{tagger commiter author owner user assignee}

defines   = []
inits     = []
nscopies  = []
encodings = []
decodings = []

json.reject!{|k, v| !!json["#{k}_count"] }

json.each{|k, v|
  next if k.start_with?('_')
  case v
  when Fixnum
    type   = TYPE_INTEGER
  when TrueClass
    type   = TYPE_BOOL
  when FalseClass
    type   = TYPE_BOOL
  end

  unless type
    if USER_KEYS.include?(k)
      type = TYPE_USER
    elsif k.end_with?('url')
      type = TYPE_URL
    elsif k.end_with?('_at')
      type = TYPE_DATE
    elsif v.is_a?(Hash)
      type = TYPE_DICT
    else
      type = TYPE_STRING
    end
  end

  key    = k
  key    = filename.sub(/\.json$/, "_#{ key }") if RESERVED.include?(key)
  key    = "is_#{ key }" if type == TYPE_BOOL && !key.start_with?("has")
  key    = ActiveSupport::Inflector.camelize(key, false)

  key.sub!(/url/i, "URL")
  key.sub!(/sha/i, "SHA")
  inits << "val = dictionary[@\"#{ k }\"];"

  assign = false
  encode = "encodeObject"
  decode = "decodeObjectForKey"
  case type
  when TYPE_BOOL
    assign = true
    encode = "encodeBool"
    decode = "decodeBoolForKey"
    inits << "if([val isKindOfClass:[NSNumber class]]) self.#{key} = [val boolValue];"
  when TYPE_DICT
    inits << "if([val isKindOfClass:[NSDictionary class]]) self.#{key} = val;"
  when TYPE_USER
    inits << "if([val isKindOfClass:[NSDictionary class]]) self.#{key} = [[AFGitHubUser alloc] initWithDictionary:val];"
  when TYPE_URL
    inits << "if(AFGitHubIsStringWithAnyText(val)) self.#{key} = [NSURL URLWithString:val];"
  when TYPE_INTEGER
    assign = true
    encode = "encodeInteger"
    decode = "decodeIntegerForKey"
    inits << "if([val isKindOfClass:[NSNumber class]]) self.#{key} = [val integerValue];"
  when TYPE_STRING
    inits << "if(AFGitHubIsStringWithAnyText(val)) self.#{key} = val;"
  when TYPE_DATE
    inits << "if(AFGitHubIsStringWithAnyText(val)) self.#{key} = [NSDate dateFromRFC3339String:val];"
  end
  defines   << "@property (nonatomic, #{ assign ? 'assign' : 'copy' }) #{type}#{key};"
  nscopies  << "copy.#{key} = self.#{key};"
  decodings << "self.#{key} = [aDecoder #{decode}:@\"#{k}\"];"
  encodings << "[aCoder #{encode}:self.#{key} forKey:@\"#{k}\"];"
}

defines.sort!

puts <<EOM
#{ defines.join("\n") }

////////////////////////////////////////////////////////////////

#pragma mark - Initializing

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self = [super init]) {
    id val = nil;
    #{ inits.join("\n") }
  }
  return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFGitHub#{ klass } *copy = [[self.class alloc] init];
  #{ nscopies.join("\n") }
  return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self = [self init]) {
    #{ decodings.join("\n") }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  #{ encodings.join("\n") }
}

EOM

