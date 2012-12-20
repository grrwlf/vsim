-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00230
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00230)
--    ENT00230_Test_Bench(ARCH00230_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES ;
use STANDARD_TYPES.test_report, STANDARD_TYPES.switch,
    STANDARD_TYPES.up, STANDARD_TYPES.down, STANDARD_TYPES.toggle,
    STANDARD_TYPES."=" ;
architecture ARCH00230 of GENERIC_STANDARD_TYPES is
   signal i_bit_vector_1, i_bit_vector_2 : st_bit_vector
       := c_st_bit_vector_1 ;
   signal i_string_1, i_string_2 : st_string
       := c_st_string_1 ;
   signal i_t_rec1_1, i_t_rec1_2 : st_rec1
       := c_st_rec1_1 ;
   signal i_st_rec1_1, i_st_rec1_2 : st_rec1
       := c_st_rec1_1 ;
   signal i_t_rec2_1, i_t_rec2_2 : st_rec2
       := c_st_rec2_1 ;
   signal i_st_rec2_1, i_st_rec2_2 : st_rec2
       := c_st_rec2_1 ;
   signal i_t_rec3_1, i_t_rec3_2 : st_rec3
       := c_st_rec3_1 ;
   signal i_st_rec3_1, i_st_rec3_2 : st_rec3
       := c_st_rec3_1 ;
   signal i_t_arr1_1, i_t_arr1_2 : st_arr1
       := c_st_arr1_1 ;
   signal i_st_arr1_1, i_st_arr1_2 : st_arr1
       := c_st_arr1_1 ;
   signal i_t_arr2_1, i_t_arr2_2 : st_arr2
       := c_st_arr2_1 ;
   signal i_st_arr2_1, i_st_arr2_2 : st_arr2
       := c_st_arr2_1 ;
   signal i_t_arr3_1, i_t_arr3_2 : st_arr3
       := c_st_arr3_1 ;
   signal i_st_arr3_1, i_st_arr3_2 : st_arr3
       := c_st_arr3_1 ;
--
begin
   L1:
   block
   port (
          toggle : inout switch := down;
          i_bit_vector_1, i_bit_vector_2 : inout bit_vector
             := c_st_bit_vector_1
             ;
          i_string_1, i_string_2 : inout string
             := c_st_string_1
             ;
          i_t_rec1_1, i_t_rec1_2 : inout t_rec1
             := c_st_rec1_1
             ;
          i_st_rec1_1, i_st_rec1_2 : inout st_rec1
             := c_st_rec1_1
             ;
          i_t_rec2_1, i_t_rec2_2 : inout t_rec2
             := c_st_rec2_1
             ;
          i_st_rec2_1, i_st_rec2_2 : inout st_rec2
             := c_st_rec2_1
             ;
          i_t_rec3_1, i_t_rec3_2 : inout t_rec3
             := c_st_rec3_1
             ;
          i_st_rec3_1, i_st_rec3_2 : inout st_rec3
             := c_st_rec3_1
             ;
          i_t_arr1_1, i_t_arr1_2 : inout t_arr1
             := c_st_arr1_1
             ;
          i_st_arr1_1, i_st_arr1_2 : inout st_arr1
             := c_st_arr1_1
             ;
          i_t_arr2_1, i_t_arr2_2 : inout t_arr2
             := c_st_arr2_1
             ;
          i_st_arr2_1, i_st_arr2_2 : inout st_arr2
             := c_st_arr2_1
             ;
          i_t_arr3_1, i_t_arr3_2 : inout t_arr3
             := c_st_arr3_1
             ;
          i_st_arr3_1, i_st_arr3_2 : inout st_arr3
             := c_st_arr3_1
            ) ;
   port map (
              toggle ,
             i_bit_vector_1, i_bit_vector_2,
             i_string_1, i_string_2,
             i_t_rec1_1, i_t_rec1_2,
             i_st_rec1_1, i_st_rec1_2,
             i_t_rec2_1, i_t_rec2_2,
             i_st_rec2_1, i_st_rec2_2,
             i_t_rec3_1, i_t_rec3_2,
             i_st_rec3_1, i_st_rec3_2,
             i_t_arr1_1, i_t_arr1_2,
             i_st_arr1_1, i_st_arr1_2,
             i_t_arr2_1, i_t_arr2_2,
             i_st_arr2_1, i_st_arr2_2,
             i_t_arr3_1, i_t_arr3_2,
             i_st_arr3_1, i_st_arr3_2
                                      ) ;
--
   begin
      process
         variable correct : boolean := true ;
      begin
         correct := correct and i_bit_vector_1 = c_st_bit_vector_1
                    and i_bit_vector_2 = c_st_bit_vector_1 ;
         correct := correct and i_string_1 = c_st_string_1
                    and i_string_2 = c_st_string_1 ;
         correct := correct and i_t_rec1_1 = c_st_rec1_1
                    and i_t_rec1_2 = c_st_rec1_1 ;
         correct := correct and i_st_rec1_1 = c_st_rec1_1
                    and i_st_rec1_2 = c_st_rec1_1 ;
         correct := correct and i_t_rec2_1 = c_st_rec2_1
                    and i_t_rec2_2 = c_st_rec2_1 ;
         correct := correct and i_st_rec2_1 = c_st_rec2_1
                    and i_st_rec2_2 = c_st_rec2_1 ;
         correct := correct and i_t_rec3_1 = c_st_rec3_1
                    and i_t_rec3_2 = c_st_rec3_1 ;
         correct := correct and i_st_rec3_1 = c_st_rec3_1
                    and i_st_rec3_2 = c_st_rec3_1 ;
         correct := correct and i_t_arr1_1 = c_st_arr1_1
                    and i_t_arr1_2 = c_st_arr1_1 ;
         correct := correct and i_st_arr1_1 = c_st_arr1_1
                    and i_st_arr1_2 = c_st_arr1_1 ;
         correct := correct and i_t_arr2_1 = c_st_arr2_1
                    and i_t_arr2_2 = c_st_arr2_1 ;
         correct := correct and i_st_arr2_1 = c_st_arr2_1
                    and i_st_arr2_2 = c_st_arr2_1 ;
         correct := correct and i_t_arr3_1 = c_st_arr3_1
                    and i_t_arr3_2 = c_st_arr3_1 ;
         correct := correct and i_st_arr3_1 = c_st_arr3_1
                    and i_st_arr3_2 = c_st_arr3_1 ;
--
         test_report ( "ENT00230" ,
         "Associated composite inout ports with generic subtypes" ,
          correct) ;
--
         toggle <= up ;
         i_bit_vector_1 <= c_st_bit_vector_2 ;
         i_bit_vector_2 <= c_st_bit_vector_2 ;
         i_string_1 <= c_st_string_2 ;
         i_string_2 <= c_st_string_2 ;
         i_t_rec1_1 <= c_st_rec1_2 ;
         i_t_rec1_2 <= c_st_rec1_2 ;
         i_st_rec1_1 <= c_st_rec1_2 ;
         i_st_rec1_2 <= c_st_rec1_2 ;
         i_t_rec2_1 <= c_st_rec2_2 ;
         i_t_rec2_2 <= c_st_rec2_2 ;
         i_st_rec2_1 <= c_st_rec2_2 ;
         i_st_rec2_2 <= c_st_rec2_2 ;
         i_t_rec3_1 <= c_st_rec3_2 ;
         i_t_rec3_2 <= c_st_rec3_2 ;
         i_st_rec3_1 <= c_st_rec3_2 ;
         i_st_rec3_2 <= c_st_rec3_2 ;
         i_t_arr1_1 <= c_st_arr1_2 ;
         i_t_arr1_2 <= c_st_arr1_2 ;
         i_st_arr1_1 <= c_st_arr1_2 ;
         i_st_arr1_2 <= c_st_arr1_2 ;
         i_t_arr2_1 <= c_st_arr2_2 ;
         i_t_arr2_2 <= c_st_arr2_2 ;
         i_st_arr2_1 <= c_st_arr2_2 ;
         i_st_arr2_2 <= c_st_arr2_2 ;
         i_t_arr3_1 <= c_st_arr3_2 ;
         i_t_arr3_2 <= c_st_arr3_2 ;
         i_st_arr3_1 <= c_st_arr3_2 ;
         i_st_arr3_2 <= c_st_arr3_2 ;
         wait ;
      end process ;
   end block L1 ;
   P00230 :
   process ( toggle )
     variable correct : boolean := true ;
   begin
      if toggle = up then
         correct := correct and i_bit_vector_1 = c_st_bit_vector_2
                    and i_bit_vector_2 = c_st_bit_vector_2 ;
         correct := correct and i_string_1 = c_st_string_2
                    and i_string_2 = c_st_string_2 ;
         correct := correct and i_t_rec1_1 = c_st_rec1_2
                    and i_t_rec1_2 = c_st_rec1_2 ;
         correct := correct and i_st_rec1_1 = c_st_rec1_2
                    and i_st_rec1_2 = c_st_rec1_2 ;
         correct := correct and i_t_rec2_1 = c_st_rec2_2
                    and i_t_rec2_2 = c_st_rec2_2 ;
         correct := correct and i_st_rec2_1 = c_st_rec2_2
                    and i_st_rec2_2 = c_st_rec2_2 ;
         correct := correct and i_t_rec3_1 = c_st_rec3_2
                    and i_t_rec3_2 = c_st_rec3_2 ;
         correct := correct and i_st_rec3_1 = c_st_rec3_2
                    and i_st_rec3_2 = c_st_rec3_2 ;
         correct := correct and i_t_arr1_1 = c_st_arr1_2
                    and i_t_arr1_2 = c_st_arr1_2 ;
         correct := correct and i_st_arr1_1 = c_st_arr1_2
                    and i_st_arr1_2 = c_st_arr1_2 ;
         correct := correct and i_t_arr2_1 = c_st_arr2_2
                    and i_t_arr2_2 = c_st_arr2_2 ;
         correct := correct and i_st_arr2_1 = c_st_arr2_2
                    and i_st_arr2_2 = c_st_arr2_2 ;
         correct := correct and i_t_arr3_1 = c_st_arr3_2
                    and i_t_arr3_2 = c_st_arr3_2 ;
         correct := correct and i_st_arr3_1 = c_st_arr3_2
                    and i_st_arr3_2 = c_st_arr3_2 ;
      end if ;
--
      test_report ( "ENT00230.P00230" ,
  "Associated composite inout ports with generic subtypes",
                correct) ;
   end process P00230 ;
end ARCH00230 ;
--
entity ENT00230_Test_Bench is
end ENT00230_Test_Bench ;
--
architecture ARCH00230_Test_Bench of ENT00230_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00230 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00230_Test_Bench ;
