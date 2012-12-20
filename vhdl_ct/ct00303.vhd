-- NEED RESULT: ARCH00303: Block port clause and port map passed
-- NEED RESULT: ARCH00303: Block with a port clause but no port map passed
-- NEED RESULT: ARCH00303: Blocks optional port map test completed correctly passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00303
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00303)
--    ENT00303_Test_Bench(ARCH00303_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00303 of E00000 is
   function To_Boolean ( p : in bit ) return boolean is
   begin
      return Boolean'Val(Bit'Pos(p)) ;
   end To_Boolean ;

   function To_Bit ( p : in boolean ) return bit is
   begin
      return Bit'Val(Boolean'Pos(p)) ;
   end To_Bit ;

   signal s1 : bit := '0' ;

   signal s2 : boolean := false ;

begin
   B1 :
   block
      port ( p1 : inout boolean ) ;
      port map ( To_Bit (p1) => To_Boolean (s1) ) ;
   begin
      process
      begin
         p1 <= transport Not p1 after 10 ns ;
         test_report ( "ARCH00303" ,
		       "Block port clause and port map" ,
		       True ) ;
         wait ;
      end process ;
   end block B1 ;

   B2 :
   block
      port ( p1 : in boolean := true) ;
   begin
      process
      begin
         s2 <= transport ((Not s2) and p1) after 10 ns ;
         test_report ( "ARCH00303" ,
		       "Block with a port clause but no port map" ,
		       True ) ;
         wait ;
      end process ;
   end block B2 ;

   P1 :
   process
   begin
      wait for 11 ns ;
      test_report ( "ARCH00303" ,
		    "Blocks optional port map test completed correctly" ,
		    (s1 = '1') and s2 ) ;
      wait ;
   end process P1 ;
end ARCH00303 ;

entity ENT00303_Test_Bench is
end ENT00303_Test_Bench ;

architecture ARCH00303_Test_Bench of ENT00303_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00303 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00303_Test_Bench ;
