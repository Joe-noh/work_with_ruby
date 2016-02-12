#!/usr/bin/env ruby

require 'json'

def receive
  length = STDIN.read(4)
  return nil unless length

  message_length = length.unpack("N").first
  STDIN.read(message_length)
end

def parse(json)
  person = JSON.parse(json)

  "Name is #{person['name']}, #{person['age'].to_s} years old."
end

while (json = receive())
  response = parse(json).to_s

  $stdout.write([response.bytesize].pack("N"))
  $stdout.write(response)

  $stdout.flush
end
