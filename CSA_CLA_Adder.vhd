----------------------------------------------------------------------------------
-- Create Date:    22:07:38 04/14/2021 
-- Designer Name:  Gaurav Kumar
-- Module Name:    CSA_Adder - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CSA_CLA_Adder is
    Generic(K: integer:=16);
    Port ( A : in  STD_LOGIC_VECTOR(K-1 downto 0);
           B : in  STD_LOGIC_VECTOR(K-1 downto 0);
           D : in  STD_LOGIC_VECTOR(K-1 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(K downto 0);
           Carry : out  STD_LOGIC);
end CSA_CLA_Adder;

architecture Behavioral of CSA_CLA_Adder is
------>>>>>>>>>>Signal And Enitity Declaration For 1 bit Full Adder---->>>>>>>>>>
Component Adder_1bit is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Carry : out  STD_LOGIC);
end component;
Signal C1,Sum1: STD_LOGIC_VECTOR(K-1 downto 0);
Signal C2,Sum2: STD_LOGIC_VECTOR(K-1 downto 0);
-->>>>>>>>>>Signal And Enitity Declaration For CLA(Carry Look Ahead) Adder->>>>>>>>>>
Component CLA_Adder is
    Generic (K: integer :=16);
    Port ( A : in  STD_LOGIC_VECTOR(K-1 downto 0);
           B : in  STD_LOGIC_VECTOR(K-1 downto 0);
			  Cin: in STD_LOGIC:='0';
           sum : out  STD_LOGIC_VECTOR(K-1 downto 0);
           carry : out  STD_LOGIC);
end Component;
------>>>>>>>>>>-------------------------------------------------------<<<<<<<<<<
begin
First_Adder:
           For I in 0 to k-1 Generate
			  ADD0: Adder_1bit port map(A=>A(I),B=>B(I),Cin=>'0',Sum=>Sum1(I),Carry=>C1(I));
			  END Generate First_Adder;
			  
ADD1: Adder_1bit port map(A=>D(0),B=>Sum1(0),Cin=>'0',Sum=>Sum2(0),Carry=>C2(0));			  
Second_Adder:
           For I in 1 to K-1 Generate
			  ADD2: Adder_1bit port map(A=>D(I),B=>Sum1(I),Cin=>C1(I-1),Sum=>Sum2(I),Carry=>C2(I));
			  END Generate Second_Adder;

Sum(0)<= Sum2(0);

CPA0: CLA_Adder generic map(K=>K) port map(A=>C2,B(K-2 downto 0)=>Sum2(K-1 downto 1),B(K-1)=>C1(K-1),Cin=>'0',
                                           sum=>Sum(K downto 1),carry=>Carry);

end Behavioral;

