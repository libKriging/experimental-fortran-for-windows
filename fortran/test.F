      integer function COMPARE(a, b, n)
            use iso_c_binding
            character a(*)      
            character b(*)
            integer n
            interface
                integer(c_int) function strncmp(dest, src, n) bind(C)
                   import
                   character,  intent(in) :: dest(*)
                   character,  intent(in)  :: src(*)
                   integer(c_int), value, intent(in) :: n
                 end function strncmp
             end interface
             COMPARE = strncmp(a, b, n)
             return
      end function COMPARE

      subroutine test(has_str_condition, has_strncmp, has_write, ttime)
      integer has_str_condition, has_strncmp, has_write
      double precision ttime
      
      integer COMPARE
      character*60     task
      task = 'START'
      
#ifdef FLIB_STR_CONDITION
      if (task == 'START') then
        has_str_condition = 1
      endif
#endif

#ifdef FLIB_STRNCMP
      if (COMPARE(task, 'START', 4) == 0) then
          has_strncmp = 1
      endif
#endif 

#ifdef FLIB_WRITE
      write(*,*) 'Hello console'
      has_write = 1
#endif

      temp = sngl(ttime)
#ifdef FLIB_CPU_TIME
      call cpu_time(temp)
#endif
      ttime = dble(temp)

      return

      end
