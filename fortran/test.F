      logical function STRCMP(a, b, n)
            use iso_c_binding
            character a(*)      
            character b(*)
            integer n
            interface
                integer(c_int) function strncmp0(dest, src, n) bind(C)
                   import
                   character,  intent(in) :: dest(*)
                   character,  intent(in)  :: src(*)
                   integer(c_int), value, intent(in) :: n
                 end function strncmp0
             end interface
             STRCMP = (strncmp0(a, b, n) == 0)
             return
      end function STRCMP
#define STREQUAL(a,b) STRCMP((a),(b),len(b))

      subroutine test(has_str_condition, has_strncmp, has_write, ttime)
      integer has_str_condition, has_strncmp, has_write
      double precision ttime
      
      logical STRCMP
      character*60     task
      task = 'START'
      
#ifdef FLIB_STR_CONDITION
      if (task == 'START') then
        has_str_condition = 1
      endif
#endif

#ifdef FLIB_STRCMP
      if (STREQUAL(task(3:5), 'ART')) then
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
