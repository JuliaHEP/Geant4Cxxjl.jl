# This file is a part of Geant4.jl, licensed under the MIT License (MIT).

using Cxx

export g4cmd
export g4rndseed
export g4physlist
export g4beamon

g4cmd(cmd::AbstractString) = icxx""" G4UImanager::GetUIpointer()->ApplyCommand($cmd); """

g4rndseed(seed::Integer) = icxx""" CLHEP::HepRandom::setTheSeed($(abs(signed(seed)))); """

# g4runmanager() = @cxx G4RunManager::GetRunManager()

g4physlist(name::AbstractString) = icxx""" G4PhysListFactory().GetReferencePhysList($name); """

g4beamon(run_manager, n::Integer) = @cxx run_manager->BeamOn(n);
