using JuLIP

println("Test Direct use of ASECalculator")
at = bulk("Cu", cubic=true) * 2    # generate periodic Cu supercell
deleteat!(at, 1)                       # vacancy defect
try
   @pyimport ase.calculators.emt as emt   # import the EMT model
   calc = ASECalculator(emt.EMT())        # wrap it into a Julia Object
   @show energy(calc, at)                 # compute the energy
   @show maximum(norm.(forces(calc, at)))
   @test true
catch
   println("failed ASECalculator Test")
   @test false
end


# println("Test ASE's EMT calculator implementation (ASE.EMTCalculator)")
# emt = ASE.EMTCalculator()
# at = rattle!( set_pbc!( bulk("Cu", cubic=true) * 2, (true,false,false) ), 0.1 )
# @test JuLIP.Testing.fdtest(emt, at, verbose=true)
#
# println("Test ASE+JuLIP implementation of EMT")
# emtj = ASE.EMT.EMTCalculator(at)
#
# println("--------------------------------------------------")
# println(" EMT Consistency test: ")
# println("--------------------------------------------------")
# println(" E_ase - E_jl = ", energy(emt, at) - energy(emtj, at))
# println(" |Frc_ase - Frc_jl = ", maximum(norm.(forces(emt, at) - forces(emtj, at))))
# println("--------------------------------------------------")
# @test abs(energy(emt, at) - energy(emtj, at)) < 1e-10
# @test JuLIP.Testing.fdtest(emtj, at, verbose=true)
