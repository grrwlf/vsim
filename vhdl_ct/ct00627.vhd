-- NEED RESULT: ARCH00627: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00627.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00627: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00627: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00627: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: P1: Transport transactions completed entirely passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00627
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00627(ARCH00627)
--    ENT00627_Test_Bench(ARCH00627_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00627 is
end ENT00627 ;
--
--
architecture ARCH00627 of ENT00627 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   subtype chk_time_type is Time ;
   signal s_st_rec3_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_rec3_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_rec3_select : select_type := 1 ;
--
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
   procedure P1
      (signal s_st_rec3 : in st_rec3 ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_rec3_cnt is
         when 0
         => null ;
              -- s_st_rec3.f3(lowb,true)(lowb to highb-1) <= transport
              --   c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 10 ns,
              --   c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3.f3(lowb,true)(lowb to highb-1) =
                 c_st_rec3_2.f3(lowb,true)(lowb to highb-1) and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00627" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_rec3.f3(lowb,true)(lowb to highb-1) =
                 c_st_rec3_1.f3(lowb,true)(lowb to highb-1) and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00627.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_rec3.f3(lowb,true)(lowb to highb-1) <= transport
              --   c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 10 ns ,
              --   c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 20 ns ,
              --   c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 30 ns ,
              --   c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3.f3(lowb,true)(lowb to highb-1) =
                 c_st_rec3_2.f3(lowb,true)(lowb to highb-1) and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00627" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_rec3.f3(lowb,true)(lowb to highb-1) <= transport
              --   c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_rec3.f3(lowb,true)(lowb to highb-1) =
                 c_st_rec3_1.f3(lowb,true)(lowb to highb-1) and
               (s_st_rec3_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00627" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00627" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00627" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_rec3_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_rec3_cnt + 1 ;
--
   end ;
--
begin
   CHG1 :
   P1(
       s_st_rec3 ,
       st_rec3_select ,
       s_st_rec3_savt ,
       chk_st_rec3 ,
       s_st_rec3_cnt ) ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   with st_rec3_select select
      s_st_rec3.f3(lowb,true)(lowb to highb-1) <= transport
        c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 10 ns,
        c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 10 ns ,
        c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 20 ns ,
        c_st_rec3_2.f3(lowb,true)(lowb to highb-1) after 30 ns ,
        c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_rec3_1.f3(lowb,true)(lowb to highb-1) after 5 ns  when 3 ;
--
end ARCH00627 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00627_Test_Bench is
end ENT00627_Test_Bench ;
--
--
architecture ARCH00627_Test_Bench of ENT00627_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00627 ( ARCH00627 ) ;
   begin
      CIS1 : UUT
         ;
   end block L1 ;
end ARCH00627_Test_Bench ;
