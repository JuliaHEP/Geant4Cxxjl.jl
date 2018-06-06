# This file is a part of Geant4.jl, licensed under the MIT License (MIT).

__precompile__(false)

module Geant4


using Compat
using Compat: axes

using Cxx


function module__prep__()
    const cl_flags = replace((@compat readstring(`geant4-config --cflags --libs`)), "\n", " ")
    const incdirs = map(s -> replace(s, "\"", "")[4:end], matchall(r" -I([^ ]+)", cl_flags))
    const libdirs = map(s -> replace(s, "\"", "")[4:end], matchall(r" -L([^ ]+)", cl_flags))
    const libs = map(s -> replace(s, "\"", "")[4:end], matchall(r" -l([^ ]+)", cl_flags))

    for dir in incdirs
        addHeaderDir(dir, kind=C_System)
    end

    for lib in libs
        const libbasename = "lib$(lib).$(Libdl.dlext)"
        local loaded = false
        for dir in libdirs
            const libfile = joinpath(dir, libbasename)
            if (isfile(libfile))
                Libdl.dlopen(libfile, Libdl.RTLD_GLOBAL)
                loaded = true
            end
        end
        !loaded && error("Couldn't find \"$(libbasename)\"")
    end

    cxxinclude("G4AssemblyVolume.hh")
    cxxinclude("G4Box.hh")
    cxxinclude("G4Color.hh")
    cxxinclude("G4EventManager.hh")
    cxxinclude("G4GeneralParticleSource.hh")
    cxxinclude("G4Material.hh")
    cxxinclude("G4Neutron.hh")
    cxxinclude("G4NistManager.hh")
    cxxinclude("G4PhysListFactory.hh")
    cxxinclude("G4PVPlacement.hh")
    cxxinclude("G4Run.hh")
    cxxinclude("G4RunManager.hh")
    cxxinclude("G4RunManager.hh")
    cxxinclude("G4Track.hh")
    cxxinclude("G4TrackingManager.hh")
    cxxinclude("G4Transform3D.hh")
    cxxinclude("G4Tubs.hh")
    cxxinclude("G4UIcmdWithADoubleAndUnit.hh")
    cxxinclude("G4UIcmdWithAString.hh")
    cxxinclude("G4UIcmdWithoutParameter.hh")
    cxxinclude("G4UIdirectory.hh")
    cxxinclude("G4UImanager.hh")
    cxxinclude("G4UItcsh.hh")
    cxxinclude("G4UIterminal.hh")
    cxxinclude("G4UserSteppingAction.hh")
    cxxinclude("G4VisAttributes.hh")
    cxxinclude("G4VisExecutive.hh")
    cxxinclude("G4VUserDetectorConstruction.hh")
    cxxinclude("G4VUserPrimaryGeneratorAction.hh")
end

module__prep__()


include("util.jl")


end # module
