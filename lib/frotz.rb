#!/usr/bin/env ruby

class Frotz
  def initialize
    dir = File.dirname __FILE__
    IO.popen "dfrotz #{dir}/ZORK1.DAT 2>/dev/null", 'w+' do |f|
      @frotz = f
      sleep 0.5
      output

      yield self
    end
  end

  def output
    @frotz.readpartial(8096)
  end

  def type s
    @frotz.puts s
    sleep 0.25
    block_given? ? yield(output) : output
  end

  def save file
    type 'save'
    unless type(file) == 'Ok.'
      type 'yes'
    end
  end

  def restore file
    type 'restore'
    type file
  end
end

Frotz.new do |f|
  save = ARGV.shift
  cmd = ARGV.join(' ')

  f.restore save  if File.exists?(save)

  f.type cmd do |s|
    s.sub! /.*\n\n/, ''
    s.sub! "\n\n>", ''
    puts s
  end
  f.save save
end  if $0 == __FILE__
