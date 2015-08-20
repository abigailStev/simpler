      subroutine simpler(ear,ne,param,ifl,photar,photer)
c fortran version of simpl, edited
      implicit none
      integer ne, ifl, i,j
      real ear(0:ne), param(3), photar(ne), photer(ne)
      real gamma,scatflag,gamma1,gamma2,engam1(0:ne),en0gam1(ne)
      real engam2(0:ne),en0gam2(ne),gnormup,gnormdn,tmparr(ne)
      real frac

      gamma=param(1)
      frac=param(2)
      scatflag=param(3)

      if (gamma.eq.1.) then
      gamma=1.001
      endif
      
      gamma1=gamma-1.
      gamma2=gamma+2.
      gnormup=((gamma+2.)/(1+2.*gamma))
      gnormdn=((gamma-1.)/(1+2.*gamma))

      engam1(0)=ear(0)**(-gamma1)
      do i=1,ne
        engam1(i)=ear(i)**(-gamma1)
        tmparr(i)=0.0
        en0gam1(i)=(0.5*(ear(i-1)+ear(i)))**gamma1
      enddo

      if (scatflag.gt.0) then
c  upscattering only
      do i=1,ne
        tmparr(i)=tmparr(i)+photar(i)*(1.-en0gam1(i)*engam1(i))
        do j=i+1,ne
      tmparr(j)=tmparr(j)+photar(i)*en0gam1(i)*(engam1(j-1)-engam1(j))
        enddo
      enddo
      else
c  upscattering and downscattering
      engam2(0)=ear(0)**(gamma2)
      do i=1,ne
        engam2(i)=ear(i)**(gamma2)
        tmparr(i)=0.0
        en0gam2(i)=(0.5*(ear(i-1)+ear(i)))**(-gamma2)
      enddo      
      do i=1,ne
      tmparr(i)=tmparr(i)+photar(i)*
     *((gnormup*(1.-en0gam1(i)*engam1(i)))
     *+(gnormdn*(1.-en0gam2(i)*engam2(i-1))))
        do j=1,ne
          if (j.lt.i) then
      tmparr(j)=tmparr(j)+
     *gnormdn*photar(i)*en0gam2(i)*(engam2(j)-engam2(j-1))
          else if (j.gt.i) then
      tmparr(j)=tmparr(j)+
     *gnormup*photar(i)*en0gam1(i)*(engam1(j-1)-engam1(j))
          endif
        enddo
      enddo
      endif
    
      do i=1,ne
        photar(i)=(photar(i))+(frac*tmparr(i))
      enddo

      return
      end
