-- NEED RESULT: ARCH00104.P1: Multi transport transactions occurred on signal asg with slice name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00104: One transport transaction occurred on signal asg with slice name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00104: Old transactions were removed on signal asg with slice name prefixed by an indexed name on LHS passed
-- NEED RESULT: P1: Transport transactions entirely completed passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00104
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3 (2)
--    8.3 (3)
--    8.3 (5)
--    8.3.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00104(ARCH00104)
--    ENT00104_Test_Bench(ARCH00104_Test_Bench)
--
-- REVISION HISTORY:
--
--    07-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00104 is
   port (
        s_st_arr1_vector : inout st_arr1_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
--
end ENT00104 ;
--
architecture ARCH00104 of ENT00104 is
begin
   PGEN_CHKP_1 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_st_arr1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_st_arr1_vector )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 10 ns,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_2(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_1(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00104.P1" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 10 ns ,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 20 ns ,
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 30 ns ,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_2(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_1(highb) (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00104" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
            test_report ( "ARCH00104" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00104" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P1 ;
--
--
end ARCH00104 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00104_Test_Bench is
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
--
end ENT00104_Test_Bench ;
--
architecture ARCH00104_Test_Bench of ENT00104_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_arr1_vector : inout st_arr1_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00104 ( ARCH00104 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_arr1_vector
                  ) ;
   end block L1 ;
end ARCH00104_Test_Bench ;
