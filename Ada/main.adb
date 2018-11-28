-- File Name: Project 4    --
-- Due Date: 11/25/18      --
-- Class: COMP 3220        --

with Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

-- Main Procedure
procedure Main is

   -- GLOBAL INITIALIZATION --
   subtype array_range is Integer range 0 .. 15;

   type BINARY_NUMBER is new Integer range 0 .. 1;
   type BINARY_ARRAY is array (array_range) of BINARY_NUMBER;

   package Binary_Number_IO is new Ada.Text_IO.Enumeration_IO(BINARY_NUMBER);
   use Binary_Number_IO;

   Index : INTEGER;



   -- CUSTOM FUNCTIONS --
   -- Random Number Function (for calculating random binary numbers (1 or 0)).
   function Array_Initialization return BINARY_ARRAY is

      package Rand_Byte is new Ada.Numerics.Discrete_Random(BINARY_NUMBER);
      use Rand_Byte;
      gen : Rand_Byte.Generator;
      returnArray : BINARY_ARRAY;

   begin -- Begin function body

      Rand_Byte.Reset(gen);

      Index := 0;
      for Index in array_range loop
         returnArray(Index) := Random(gen);
      end loop;

      return returnArray;

   end Array_Initialization; -- End Random Number Function


   -- Function for Complementing Arrays (helps with subtraction of them).
   function ComplementArray (b : BINARY_ARRAY) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;

   begin

      for Index in array_range loop
         if b(Index) = 1 then
            arrayReturn(Index) := 0;
         else
            arrayReturn(Index) := 1;
         end if;
      end loop;

      return arrayReturn;

   end ComplementArray; -- End ComplementArray Function



   -- REQUIRED FUNCTIONS --
   -- Bin_To_Int Function (Reads BINARY_ARRAY and returns number equivalent to the 16-bit binary number).
   function Bin_To_Int (b : BINARY_ARRAY) return Integer is

      integerAnswer : INTEGER;

   begin -- Begin Function Body

      integerAnswer := 0;
      Index := 0;
      for Index in array_range loop
         if b(Index) = 1 then
            integerAnswer := integerAnswer + 2**(15 - Index);
         end if;
      end loop;

      return integerAnswer;

   end Bin_To_Int; -- End Bin_To_Int Function


   -- Int_To_Bin Function (Reads Integer and returns array with 16-bit binary number equivalent to the Integer).
   function Int_To_Bin (i : INTEGER) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;
      number : INTEGER;

   begin -- Begin Function Body

      if abs i <= 65535 then
         Index := 0;
         number := i rem 2**16;
         for Index in array_range loop
            arrayReturn(Index) := BINARY_NUMBER (number / 2**(15 - Index));
            number := number rem 2**(15 - Index);
         end loop;
      end if;
      if abs i > 65535 then
         Put("Number is too big! Must be 65535 at the most.");
      end if;

      return arrayReturn;

   end Int_To_Bin; -- End Int_To_Bin Function


   -- Overloaded addition operator to add two binary arrays together.
   function "+" (p1 : BINARY_ARRAY; p2 : BINARY_ARRAY) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;
      sum : Integer;
      carry : BINARY_NUMBER;

   begin -- Begin Function Body

      carry := 0;
      sum := 0;
      for Index in array_range loop
         sum := Integer(carry) + Integer(p1(15 - Index)) + Integer(p2(15 - Index));
         if sum = 0 then
            carry := 0;
            arrayReturn(15 - Index) := 0;
         elsif sum = 1 then
            carry := 0;
            arrayReturn(15 - Index) := 1;
         elsif sum = 2 then
            carry := 1;
            arrayReturn(15 - Index) := 0;
         else
            carry := 1;
            arrayReturn(15 - Index) := 1;
         end if;
      end loop;

      return arrayReturn;

   end "+"; -- End Overloaded "+" Operator (First Definition).


   -- Overloaded addition operator to add a binary array and an integer together.
   function "+" (p1 : Integer; p2 : BINARY_ARRAY) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;
      integerToArray : BINARY_ARRAY;

   begin -- Begin Function Body

      integerToArray := Int_To_Bin(p1);
      arrayReturn := "+"(integerToArray, p2);
      return arrayReturn;

   end "+"; -- End Overloaded "+" Operator (Second Definition).


   -- Overloaded subtraction operator to subtract a binary array from another binary array.
   function "-" (p1 : BINARY_ARRAY; p2 : BINARY_ARRAY) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;
      complementedP2 : BINARY_ARRAY;
      sumOfBoth : BINARY_ARRAY;
      oneIn16Bit : BINARY_ARRAY;

   begin -- Begin Function Body

      oneIn16Bit(15) := BINARY_NUMBER(1);
      for n in Integer range 0..14 loop
         oneIn16Bit(n) := BINARY_NUMBER(0);
      end loop;
      complementedP2 := ComplementArray(p2);
      sumOfBoth := "+"(p1, complementedP2);
      arrayReturn := "+"(sumOfBoth, oneIn16Bit);
      return arrayReturn;

   end "-"; -- End Overloaded "-" Operator (First Definition).


   -- Overloaded subtraction operator to subtract an integer from a binary array.
   function "-" (p1 : Integer; p2 : BINARY_ARRAY) return BINARY_ARRAY is

      arrayReturn : BINARY_ARRAY;
      integerToArray : BINARY_ARRAY;

   begin -- Begin Function Body

      integerToArray := Int_To_Bin(p1);
      arrayReturn := "-"(integerToArray, p2);
      return arrayReturn;

   end "-"; -- End Overloaded "-" Operator (Second Definition).



   -- REQUIRED PROCEDURES --
   -- Procedure for printing a binary array given as a parameter.
   procedure Print_Bin_Arr (b : BINARY_ARRAY) is

      arrayReturn : String := "                         ";

   begin -- Begin Procedure Body

      Index := 0;
      for Index in array_range loop
         if b(Index) = BINARY_NUMBER(0) then
            arrayReturn(Index + 1) := '0';
         elsif B(Index) = BINARY_NUMBER(1) then
            arrayReturn(Index + 1) := '1';
         else
            Put("Invalid!");
         end if;
      end loop;
      Put(arrayReturn);
      New_Line;

   end Print_Bin_Arr; -- End procedure for printing given binary array.


   -- Procedure for reversing a binary array given as a parameter.
   procedure Reverse_Bin_Arr (b : BINARY_ARRAY) is

     arrayReturn : BINARY_ARRAY;

   begin -- Begin Procedure Body

      for Index in array_range loop
         arrayReturn(Index) := b(15 - Index);
      end loop;
      Print_Bin_Arr(arrayReturn);

   end Reverse_Bin_Arr; -- End procedure for reversing given binary array.



   -- VALUES FOR MAIN BODY (included here for convenience for reader) --
   Array1 : BINARY_ARRAY; -- For Bin_To_Int
   Array2 : BINARY_ARRAY; -- For Int_To_Bin
   Array3 : BINARY_ARRAY; -- For overloaded "+" operator
   Array4 : BINARY_ARRAY; -- For overloaded "-" operator and Reverse_Bin_Array
   intResult : Integer; -- For integer returns

begin -- Begin Main Procedure Body

   -- Array Randomization
   Array1 := Array_Initialization;
   Put_Line("Printing Random Array My_Array: ");
   Print_Bin_Arr(Array1);
   New_Line(3);

   -- Int value of Array
   intResult := Bin_To_Int(Array1);
   Put_Line("Printing Integer value of My_Array");
   Put_Line(Integer'Image(intResult));
   New_Line(3);

   -- Int_To_Bin(55)
   Array2 := Int_To_Bin(55);
   Put_Line("Printing Array created from Int_To_Bin function: Int_To_Bin(55);");
   Print_Bin_Arr(Array2);
   New_Line(3);

   -- First "+" operator overload, int value of all 3 Arrays, and binary value of end Array
   Put_Line("Printing value of My_Array + Another_Array, first + overload");
   Put_Line("Int value of My_Array:" & Integer'Image(intResult));
   intResult := Bin_To_Int(Array2);
   Put_Line("Int value of Another_Array:" & Integer'Image(intResult));
   Array3 := "+"(Array1, Array2);
   intResult := Bin_To_Int(Array3);
   Put_Line("Int value of Array3:" & Integer'Image(intResult));
   Put("Binary value of Array3: ");
   Print_Bin_Arr(Array3);
   New_Line(3);

   -- Second "+" operator overload, int and binary of end Array
   Put_Line("Printing value of Int_To_Bin(10) + Array3, second + overload");
   Array4 := "+"(10, Array3);
   intResult := Bin_To_Int(Array4);
   Put_Line("Int value of Array3 after addition:" & Integer'Image(intResult));
   Put_Line("Current binary value of Array3: ");
   Print_Bin_Arr(Array4);
   New_Line(3);

   -- First "-" operator overload, int values of all 3 Arrays, and binary of end Array
   Put_Line("Printing value of My_Array - Another_Array, first - overload");
   intResult := Bin_To_Int(Array1);
   Put_Line("Int value of My_Array:" & Integer'Image(intResult));
   Array2 := Int_To_Bin(55);
   intResult := Bin_To_Int(Array2);
   Put_Line("Int value of Another_Array:" & Integer'Image(intResult));
   Array4 := "-"(Array1, Array2);
   intResult := Bin_To_Int(Array4);
   Put_Line("Int value of Array 4 (Note, this value will be incorrect if first number is smaller than second):" & Integer'Image(intResult));
   Put("Binary value of Array 4: ");
   Print_Bin_Arr(Array4);
   New_Line(3);

   -- Second "-" operator overload (used incorrectly), int values of two Arrays, and binary of end Array
   Put_Line("Printing value of Int_To_Bin(16384) - My_Array, second - overload");
   intResult := Bin_To_Int(Array1);
   Put_Line("Int value of My_Array:" & Integer'Image(intResult));
   Array4 := "-"(Int_To_Bin(16384), Array1);
   intResult := Bin_To_Int(Array4);
   Put_Line("Int value of Array4 after modification: " & Integer'Image(intResult));
   Put("Binary value of Array4: ");
   Print_Bin_Arr(Array4);
   New_Line(3);

   -- Reversing and printing the end array
   Put_Line("Reversing and printing Array4: ");
   Reverse_Bin_Arr(Array4);
   New_Line(3);

end Main; -- End main procedure
