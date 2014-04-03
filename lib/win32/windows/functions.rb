require 'ffi'
require_relative 'structs'

module Windows
  module SoundFunctions
    extend FFI::Library

    typedef :ulong, :dword
    typedef :uintptr_t, :hmodule
    typedef :uintptr_t, :hwaveout

    ffi_lib :kernel32

    private

    def self.attach_pfunc(*args)
      attach_function(*args)
      private args[0]
    end

    attach_pfunc :Beep, [:dword, :dword], :bool

    ffi_lib :winmm

    attach_pfunc :PlaySound, [:string, :hmodule, :dword], :bool
    attach_pfunc :waveOutSetVolume, [:hwaveout, :dword], :int
    attach_pfunc :waveOutGetVolume, [:hwaveout, :pointer], :int
    attach_pfunc :waveOutGetNumDevs, [], :int
    attach_pfunc :waveInGetNumDevs, [], :int
    attach_pfunc :midiOutGetNumDevs, [], :int
    attach_pfunc :midiInGetNumDevs, [], :int
    attach_pfunc :auxGetNumDevs, [], :int
    attach_pfunc :mixerGetNumDevs, [], :int
  end
end