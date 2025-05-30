c     XAFS Analysis Tool utilizing ifeffit
c     Wrritten by: Lucas Smale, Grant Schuster
c     Supervisor:  Chris Chantler
c     Started:     17 September 2003
c
c     This program relies on ifeffit version 1.2.3 or later and 
c     PGPLOT being installed.
c     This program sends commands to iffefit, gets the results back and
c     does a fitting procedure to minimise chisq difference in either
c     momentum or real space and with different k-weightings.
c
c     To execute this program compile using:
c     'make' with the Makefile configured according to the
c     ifeffit documentation
c     and, while using csh, add an alias to your .cshrc file to
c     make life easier:
c     alias gms_xafs home/your_user_name/path_to_program/gms_xafs
c     Then go to the directory where your FEFF8 and experimental data
c     is and type 'gms_xafs' to run.  
c ---------------------------------------------------------------
      implicit none

      integer i,j
      integer max_num_paths
      real*8 kmin,kmax,dk
      real*8 kweight
      
      real*8 amp_guess,amp_target,scale
      real*8 amp,b

      real*8 rmin,rmax,dr
      real*8 e0

      integer do_plots
      integer windowing
      integer full_model
      integer real_chi2
      character*128 arg1
      character*128 ifeffit_arg
      character*128 winstr,kwstr,realstr, filestr
      integer n_args

c     Tell the program where to find the ifeffit library file:
      include 'ifeffit.inc'
  
c     Default options
      do_plots = 0.00     ! No Plots
      windowing = 1       ! Do Widowing
      max_num_paths=1    ! 12 Paths
      full_model = 1      ! Use Full Model
      real_chi2=0.00      ! Use standard analysis

c      amp_guess  = 0.85d0
c      amp_target = 0.85d0
c      scale = 100d0
c      amp = abs(amp_guess - amp_target) * scale
      
      
c     Initialise some parameters

      e0=8.333d3
      kmin=2.0d0
      kmax=1.20d1
      dk=3.d-1
      
      rmin=1.0d0
      rmax=3.0d0
      dr=3.d-1

      kweight=0.0d0
      

c----------------------- RESTRAINT SETTING
      amp_guess  = 0.85
      amp_target = 0.85
      scale = 100
      amp = abs(amp_guess - amp_target) * scale

      write(ifeffit_arg,'(A,F20.9)')'amp_guess=',amp_guess
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'amp_target=',amp_target
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'scale=',scale
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'amp =',amp
      i = ifeffit(ifeffit_arg)

c      i = ifeffit('guess(delta_k1= 0.)')
c      i = ifeffit('def k1_calc = delta_k1 + 1')
c      i = ifeffit('set k1_expec = 1')
c      i = ifeffit('set k1_uncer = 0.03')
c      i = ifeffit('def k1_lambda= (k1_calc - k1_expec)/(k1_uncer)')
c---------------------------------------------------------------------

c     Initialise ifeffit and
c     Set up for screen echo so that we can see what is being
c     reported in IFEFFIT:
      i = ifeffit(' ')
      i = ifeffit('reset')
      i = ifeffit('history(lfs_xafs_his.txt)')

c     i = ifeffit('res1 = abs(min(theta,0))^16')
c ----- IFEFFIT MACROS:
c     Let's create a Fourier Filter Macro in IFEFFIT:

      i = ifeffit('macro do_kweight')
c     i = ifeffit('set $1.chik = $1.chi * $1.k^kweight')
      i = ifeffit('set $1.chik_w = $1.chik * $1.win')
      i = ifeffit('end macro')

      i = ifeffit('guess(e0_cor=-5.791448)')
      i = ifeffit('guess(alpha=0.0)')
      i = ifeffit('guess(sigma2=0.002467)')

      if (full_model.eq.1) then
        call load_full_model(max_num_paths)
      else if (full_model.eq.0) then
        call load_redu_model(max_num_paths) 
      else
        call load_fredu_model(max_num_paths) 
      end if

      i = ifeffit('read_data(file=data/chi_k.dat,group=mudata)')

      if (windowing.eq.0) then
        i = ifeffit('kmax = ceil(mudata.k)+0.2')
        i = iffgetsca('kmax',kmax)
        i = ifeffit('kmin = floor(mudata.k)-0.2')
        i = iffgetsca('kmin',kmin)
        dk=0
      end if

c      i = ifeffit("$fit_space='k'")

c---------------------------------------------------------------------
c     set the E0 value
      e0=8.333d3

      write(ifeffit_arg,'(A,F20.9)')'kweight=',kweight
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'kmin   =',kmin
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'kmax   =',kmax
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'dk     =',dk
      i = ifeffit(ifeffit_arg)

      
c     r window setting

      write(ifeffit_arg,'(A,F20.9)')'rmin   =',rmin
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'rmax   =',rmax
      i = ifeffit(ifeffit_arg)
      write(ifeffit_arg,'(A,F20.9)')'dr     =',dr
      i = ifeffit(ifeffit_arg)


      i = ifeffit('show kweight')
      i = ifeffit('show kmin')
      i = ifeffit('show kmax')
      i = ifeffit('show dk')
      i = ifeffit('show rmin')
      i = ifeffit('show rmax')
      i = ifeffit('show dr')
      
c      i = ifeffit('show amp')

      i = ifeffit('do_bkg=true')
c      i = ifeffit('res1 = abs(min(theta,0))^16')
      if (real_chi2.ne.1) then
      
c-------------Do The Fit with feffit
        if (max_num_paths.lt.10) then
          write(ifeffit_arg,'(A,I1,A,A)')'feffit(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi',
     &        ', group=fit, restraint=amp)'
        else
          write(ifeffit_arg,'(A,I2,A,A)')'feffit(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi',
     &        ', group=fit, restraint=amp)'
        end if 
        i = ifeffit(ifeffit_arg)

c-------------Calculate the graph
        if (max_num_paths.lt.10) then
          write(ifeffit_arg,'(A,I1,A)')'ff2chi(1-',max_num_paths,
     &                ', group=feffit)'
        else
          write(ifeffit_arg,'(A,I2,A)')'ff2chi(1-',max_num_paths,
     &              ', group=feffit)'
        end if
        i = ifeffit(ifeffit_arg)
        i = ifeffit('set(tempkw = kweight)')

        if (max_num_paths.lt.10) then
          write(ifeffit_arg,'(A,I1,A,A)')'feffit2(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi, dchi=mudata.dchi',
     &        ', group=fit, restraint=amp,onlychi2=true)'
        else
          write(ifeffit_arg,'(A,I2,A,A)')'feffit2(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi, dchi=mudata.dchi',
     &        ', group=fit, restraint=amp,onlychi2=true)'
        end if
        i = ifeffit(ifeffit_arg)
        i = ifeffit('set(tempkw = kweight)')
      else
c-------------Do The Fit with feffit2
        if (max_num_paths.lt.10) then
          write(ifeffit_arg,'(A,I1,A,A)')'feffit2(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi',
     &        ', dchi=mudata.dchi, group=fit, restraint=amp)'
        else
          write(ifeffit_arg,'(A,I2,A,A)')'feffit2(1-',max_num_paths,
     &        ', k=mudata.k, chi=mudata.chi',
     &        ', dchi=mudata.dchi, group=fit, restraint=amp)'
        end if
        i = ifeffit(ifeffit_arg)
        i = ifeffit('set(tempkw = kweight)')
        
       endif
      
      

      i = ifeffit('show @paths')      
      i = ifeffit('show @variables')
c     i = ifeffit('correl(@all,@all,print)')
      i = ifeffit('show chi_square, chi_reduced, r_factor')
      i = ifeffit('show epsilon_k, epsilon_r, n_idp, n_varys')
      i = ifeffit('show &fit_iteration')


c     i = ifeffit('e0_final=e0+e0_cor')

      i = ifeffit('show kweight')

      i = ifeffit('log(file=variables.out)')
      i = ifeffit('&screen_echo=2')

      i = ifeffit('show kweight, kmin, kmax, dk')
      i = ifeffit('show rmin, rmax, dr')
      i = ifeffit('show chi_square, chi_reduced')
      i = ifeffit('show epsilon_k')
      i = ifeffit('show mychi_square, mychi_reduced')

      i = ifeffit('show @variables')
      i = ifeffit('log(close)')
      i = ifeffit('&screen_echo=0')


      i=ifeffit('history(off)')
      end


c--------------------------------------------------------
      subroutine load_full_model(num_paths)
      integer num_paths
      integer i,j
      character*128 ifeffit_arg
      
      if (num_paths.gt.99) then
        num_paths = 99
        write(*,*) 'Warning: Only 99 paths loaded'
      endif

c      i = ifeffit('ss2_norm_correction=0.00023')
c      i = ifeffit('guess(s02=1)')

      do j=1,num_paths
         if (j.lt.10) then
              write(ifeffit_arg,'(A,I1,A)'),'guess(s02=1.0)'
              i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(index=',j,
     &                                   ',feff=feff/feff000',j,'.dat,'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I1,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
             
             
            write(ifeffit_arg,'(A,I1,A,I1,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         else
             write(ifeffit_arg,'(A,I2,A)')'guess(s02=1.0)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(index=',j,
     &                                   ',feff=feff/feff00',j,'.dat,'
            i = ifeffit(ifeffit_arg)
             write(ifeffit_arg,'(A,I2,A,I2,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I2,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         end if
      end do

      return
      end

c--------------------------------------------------------
      subroutine load_redu_model(num_paths)
      integer num_paths
      integer i,j
      character*128 ifeffit_arg
      
      if (num_paths.gt.99) then
        num_paths = 99
        write(*,*) 'Warning: Only 99 paths loaded'
      endif

c      i = ifeffit('s02_norm_correction=0.00023')
       i = ifeffit('guess(s02=1)')

      do j=1,num_paths
         if (j.lt.10) then
c             write(ifeffit_arg,'(A,I1,A)')'guess(s02=1.0)'
c             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(index=',j,
     &                                   ',feff=feff/feff000',j,'.dat,'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I1,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         else
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(index=',j,
     &                                   ',feff=feff/feff00',j,'.dat,'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I2,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         end if
      end do

      return
      end

c--------------------------------------------------------
      subroutine load_fredu_model(num_paths)
      integer num_paths
      integer i,j
      character*128 ifeffit_arg
      
      if (num_paths.gt.99) then
        num_paths = 99
        write(*,*) 'Warning: Only 99 paths loaded'
      endif

c      i = ifeffit('s02_norm_correction=0.00023')
       i = ifeffit('s02 = 1')

      do j=1,num_paths
         if (j.lt.10) then
c            write(ifeffit_arg,'(A,I1,A)')'guess(s02=1.0)'
c            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(index=',j,
     &                                   ',feff=feff/feff000',j,'.dat,'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I1,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I1,A,I1,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         else
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(index=',j,
     &                                   ',feff=feff/feff00',j,'.dat,'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A)')'label=path ',j,
     &                                   ', s02=s02,e0=e0_cor)'
            i = ifeffit(ifeffit_arg)

             write(ifeffit_arg,'(A,I2,A)')'path(',j,
     &                              ', sigma2=sigma2)'
             i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'get_path(',j,
     &                                    ', prefix=path',j,')'
            i = ifeffit(ifeffit_arg)
            write(ifeffit_arg,'(A,I2,A,I2,A)')'path(',j,
     &                                   ', delr=alpha*reff)'
            i = ifeffit(ifeffit_arg)
         end if
        end do

       return
      end