-- NEED RESULT: ARCH00401.P1: Multi inertial transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00401: One inertial transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00401: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00401: One inertial transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00401: Inertial semantics check on a concurrent signal asg passed
-- NEED RESULT: P1: Inertial transactions completed entirely passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00401
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (3)
--    9.5.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00401(ARCH00401)
--    ENT00401_Test_Bench(ARCH00401_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00401 is
end ENT00401 ;
--
--
architecture ARCH00401 of ENT00401 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
--
   subtype chk_time_type is Time ;
   signal s_st_arr1_vector_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_arr1_vector_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 6 ;
   signal st_arr1_vector_select : select_type := 1 ;
--
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
--
begin
   CHG1 :
   process
      variable correct : boolean ;
   begin
      case s_st_arr1_vector_cnt is
         when 0
         => null ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_2(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00401.P1" ,
              "Multi inertial transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr1_vector_select <= transport 2 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_2(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            st_arr1_vector_select <= transport 3 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00401" ,
              "One inertial transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            st_arr1_vector_select <= transport 4 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00401" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
            st_arr1_vector_select <= transport 5 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_2(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00401" ,
              "One inertial transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            st_arr1_vector_select <= transport 6 ;
              -- Last transaction above is marked
              -- s_st_arr1_vector(highb)(lowb to highb-1) <=
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct :=
               correct and
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00401" ,
              "Inertial semantics check on a concurrent " &
              "signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00401" ,
              "Inertial semantics check on a concurrent " &
              "signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr1_vector_savt <= transport Std.Standard.Now ;
      chk_st_arr1_vector <= transport s_st_arr1_vector_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr1_vector_cnt <= transport s_st_arr1_vector_cnt + 1 ;
      wait until (not s_st_arr1_vector(highb)(lowb to highb-1)'Quiet) and
                 (s_st_arr1_vector_savt /= Std.Standard.Now) ;
--
   end process CHG1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions completed entirely",
           chk_st_arr1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   with st_arr1_vector_select select
      s_st_arr1_vector(highb)(lowb to highb-1) <=
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 5 ns
        when 3,
--
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 100 ns
        when 4,
--
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns
        when 5,
--
        -- Last transaction above is marked
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns  when 6 ;
--
end ARCH00401 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00401_Test_Bench is
end ENT00401_Test_Bench ;
--
--
architecture ARCH00401_Test_Bench of ENT00401_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00401 ( ARCH00401 ) ;
   begin
      CIS1 : UUT
         ;
   end block L1 ;
end ARCH00401_Test_Bench ;
