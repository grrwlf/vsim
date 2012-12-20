-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00210
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00210(ARCH00210)
--    ENT00210_Test_Bench(ARCH00210_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00210 is
   generic (G : integer) ;
   port (
        s_st_rec3 : inout st_rec3
        ) ;
--
   constant CG : integer := G+1;
   attribute attr : integer ;
   attribute attr of CG : constant is CG+1;
--
end ENT00210 ;
--
--
architecture ARCH00210 of ENT00210 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   procedure Proc1 (
        signal s_st_rec3 : inout st_rec3
      ; variable counter : inout integer
      ; variable correct : inout boolean
      ; variable savtime : inout time
      ; signal chk_st_rec3 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         =>
            s_st_rec3.f1 <= transport
                c_st_rec3_2.f1 ;
            s_st_rec3.f2 <= transport
                c_st_rec3_2.f2 after 10 ns ;
            wait until s_st_rec3.f2 =
                       c_st_rec3_2.f2 ;
            Test_Report (
              "ENT00210",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3.f2 =
                   c_st_rec3_2.f2 )) ;
--
         when 1
         =>
            s_st_rec3.f1 <= transport
                c_st_rec3_1.f1 ;
            s_st_rec3.f3 <= transport
                c_st_rec3_2.f3 after 10 ns ;
            wait until s_st_rec3.f3 =
                       c_st_rec3_2.f3 ;
            Test_Report (
              "ENT00210",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3.f3 =
                   c_st_rec3_2.f3 )) ;
--
         when others
         => wait ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc1 ;
--
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time := 0 ns ;
   begin
      Proc1 (
           s_st_rec3
          , counter
          , correct
          , savtime
          , chk_st_rec3
         ) ;
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Wait longest static prefix test completed",
           chk_st_rec3 = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
end ARCH00210 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00210_Test_Bench is
end ENT00210_Test_Bench ;
--
--
architecture ARCH00210_Test_Bench of ENT00210_Test_Bench is
begin
   L1:
   block
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
      component UUT
         generic (G : integer) ;
         port (
              s_st_rec3 : inout st_rec3
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00210 ( ARCH00210 ) ;
   begin
      CIS1 : UUT
         generic map (lowb+2)
         port map (
              s_st_rec3
              )
      ;
   end block L1 ;
end ARCH00210_Test_Bench ;
