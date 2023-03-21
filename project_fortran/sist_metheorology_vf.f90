! master program
! Climate ocean-atmospheric system

program sist_metheorology
    implicit none
    ! define input values
    double precision :: a = 0, b = 1, y1_ini = 9, y2_ini = 9, y3_ini = 9, lmd1 = 1, lmd2 = 3.6
    integer :: n = 365

    ! define informative variables about models
    character(len = 275) :: dy1_dt, dy2_dt, dy3_dt
    character(len = 275), dimension(3) :: f

    ! define the label of expressions for system of diff. eq.
    dy1_dt = "(dq-lam*(y1-y2)-la*y1)/ca"
    dy2_dt = "(-lam*(y2-y1)-lmd*(y2-y3))/cm"
    dy3_dt = "(-lmd*(y3-y2))/cd"
    f = (/ dy1_dt, dy2_dt, dy3_dt /)

    ! print information about the models
    print *, "*** System of differential equations ***"
    write(*, *) "expression 1 ==> dy1/dt = ", f(1)
    write(*, *) "expression 2 ==> dy2/dt = ", f(2)
    write(*, *) "expression 3 ==> dy3/dt = ", f(3)

    !! --- execute variant 13 ---

    !! execute routine for lmd = 1
    write(*, *) "experiment for lmd = ", lmd1
    call computation_process(a, b, y1_ini, y2_ini, y3_ini, n, lmd1)
    !! execute routine for lm = 3.6
    write(*, *) "experiment for lmd = ", lmd2
    call computation_process(a, b, y1_ini, y2_ini, y3_ini, n, lmd2)

    !! adding plot functionality fortran + gnuplot
    open(unit = 10, file = "resvar13_lmd1.dat", status = "unknown")
    open(unit = 11, file = "resvar13_lmd2.dat", status = "unknown")
    call system("gnuplot -p gnuplot_res.plt")
    !!

contains

    subroutine computation_process(a, b, y1_ini, y2_ini, y3_ini, n, lmd)
        implicit none
        ! input variables
        double precision, intent(in) :: a, b, y1_ini, y2_ini, y3_ini, lmd        
        integer, intent(in) :: n
        ! variables for computation
        double precision :: h
        double precision :: T(1, n+1), sol(n+1, 4)
        ! variables for math-model
        double precision :: y1, y2, y3, dq, ca, cm, cd, la, lam, Y(3, n+3)
        double precision :: k1(3), k2(3), k3(3), k4(3), ak(3), bk(3), ck(3)
        integer :: i, j

        ! initialization of constants
        dq = 1.3
        ca = 0.45; cm = 10; cd = 100
        la = 2.4; lam = 45

        ! compute step
        h = (b - a)/n

        ! initialize vector of times
        do j = 1, (n+1)
            T(1, j) = 0
        end do

        ! initialize vectors y1, y2, y3
        do i = 1, 3
            do j = 1, (n+1)
                Y(i, j) = 0
            end do
        end do

        ! split time in timestamp
        do j = 1, (n+1)
            T(1, j) = a + (j-1) * h 
        end do 

        ! define the initial conditions
        Y(1, 1) = y1_ini
        Y(2, 1) = y2_ini
        Y(3, 1) = y3_ini

        ! iterative cycle
        do j = 1, n
            ! recover variables y1, y2, y3
            y1 = Y(1, j)
            y2 = Y(2, j)
            y3 = Y(3, j)

            ! calculate k1, k2, k3, k4 for each variable
            ! compute k1 [use vectorization for k1(1), k1(2), k1(3)]        
            k1 = func(y1, y2, y3, dq, ca, cm, cd, la, lam, lmd)
                    
            ! compute k2 [use vectorization for k2(1), k2(2), k2(3)]
            do i = 1, 3
                ak(i) = (h/2) * k1(i)
            end do

            k2 = func(y1 + ak(1), y2 + ak(2), y3 + ak(3), dq, ca, cm, cd, la, lam, lmd)

            ! compute k3 [use vectorization for k3(1), k3(2), k3(3)]
            do i = 1, 3
                bk(i) = (h/2) * k2(i)
            end do 

            k3 = func(y1 + bk(1), y2 + bk(2), y3 + bk(3), dq, ca, cm, cd, la, lam, lmd)

            ! compute k4 [use vectorization for k4(1), k4(2), k4(3)]
            do i = 1, 3
                ck(i) = h * k3(i)
            end do 

            k4 = func(y1 + ck(1), y2 + ck(2), y3 + ck(3), dq, ca, cm, cd, la, lam, lmd)

            ! update values for Y
            do i = 1, 3
                Y(i, j+1) = Y(i, j) + (h/6) * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i))
            end do        

        end do

        ! structure the results
        do j = 1, (n+1)
            sol(j, 1) = T(1, j)

            do i = 1, 3
                sol(j, i+1) = Y(i, j)
            end do 
        end do 

        ! print results
        do j = 1, (n+1)
            do i = 1, 4
                write(*, '("  ", f18.15)', advance = "no") sol(j, i)
            end do

            write(*, *)
        end do 

    end subroutine computation_process

    ! function to calculate math-expressions of diff.eq
    function func(y1, y2, y3, dq, ca, cm, cd, la, lam, lmd) result(Y)
        double precision, intent(in) :: y1, y2, y3, dq, ca, cm, cd, la, lam, lmd
        double precision :: Y(3)

        ! differential equations formulas
        Y(1) = (dq-lam*(y1-y2)-la*y1)/ca
        Y(2) = (-lam*(y2-y1)-lmd*(y2-y3))/cm
        Y(3) = (-lmd*(y3-y2))/cd

    end function func

end program sist_metheorology

! comment to compile
! > gfortran sist_metheorology_vf.f90 -o sist_metheorology_vf
! comment to run
! > sist_metheorology_vf.exe

