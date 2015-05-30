require "redis/mapper/version"

require "redis"
require "msgpack"


class Redis
  module Mapper
    def self.included(klass)
      klass.class_eval do
        class << self
          def establish_connection(host: @host, port: @port, db: @db)
            host ||= "127.0.0.1"
            port ||= redis_default_port
            if db.nil?
              raise "error: you must specify db number"
            end
            @redis = Redis.new(host: host, port: port, db: db)
          end

          def find(redis_key)
            redis_val = @redis.get(redis_key.to_s)
            redis_val and create_from_val(redis_key, redis_val)
          end

          def create!(redis_key)
            new(redis_key)
          end

          def find_or_create(redis_key)
            redis_val = @redis.get(redis_key.to_s)
            redis_val.nil? ? new(redis_key) : create_from_val(redis_key, redis_val)
          end

          def create_from_val(redis_key, redis_val)
            h = MessagePack.unpack(redis_val)
            new(redis_key, h)
          end

          def redis
            @redis
          end

          def dump
            @redis.save
          end

          def redis_default_port
            6379
          end

          private :create_from_val, :redis_default_port, :new
        end
      end

      def initialize(redis_key, h = {})
        @redis_key = redis_key
        @h = h
      end

      def get(k)
        @h[k]
      end

      def set(k, v)
        @h[k] = v
      end

      def save
        packed = @h.to_msgpack
        self.class.redis.set(@redis_key.to_s, packed)
      end
    end
  end
end
