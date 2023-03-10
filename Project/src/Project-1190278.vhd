-- Ibrahim Nobani || 1190278 || section 2.
-- A simple implementation of all gates with their desired Delays.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity inverter2 is 
	port(x:in std_logic; y:out std_logic);
end;

architecture simple of inverter2 is
begin
	y<= not x after 2 ns;
end;  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nand5 is 
	port(inNand,inNand2:in std_logic; outNand:out std_logic);
end;

architecture simple of nand5 is
begin
	outNand<= inNand nand inNand2 after 5 ns;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nor5 is 
	port(inNor,inNor2:in std_logic; outNor:out std_logic);
end;

architecture simple of nor5 is
begin
	outNor<= inNor nor inNor2 after 5 ns;
end;  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity and7 is 
	port(inAnd,inAnd2:in std_logic; outAnd:out std_logic);
end;

architecture simple of and7 is
begin
	outAnd<= inAnd and inAnd2 after 7 ns ;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity or7 is 
	port(inOr,inOr2:in std_logic; outOr:out std_logic);
end;

architecture simple of or7 is
begin
	
	outOr<= inOr or inOr2 after 7 ns ;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity xnor9 is 
	port(inXNor,inXNor2:in std_logic; outXNor:out std_logic);
end;

architecture simple of xnor9 is
begin
	outXNor<= inXNor xnor inXNor2 after 9 ns ;
end; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity xor12 is 
	port(inXor,inXor2:in std_logic; outXor:out std_logic);
end;

architecture simple of xor12 is
begin
	outXor<= inXor xor inXor2 after 12 ns ;
end;
-- d flip flop, takes clock in and D, gives Q value of D when the clock rises.
Library Ieee;
use Ieee.std_logic_1164.all;
entity DFlipFlop is 
   port(clk:in std_logic; D :in std_logic; Q:out std_logic);
end ;
architecture behave of DFlipFlop is  
begin  
 process(clk)
 begin 
    if(rising_edge(clk)) then
   Q <= D; 
    end if;       
 end process;  
end;
--Stage 2:
-- one bit comparator using structural logic gates, 4 inputs (a,b to be compared, G,L to be used for comparison) and 3 outputs.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity onebitcomp is
	port (a,b,G,L:in std_logic; greater1, equal1, less1: out std_logic);
end;
architecture structural of onebitcomp is
     -- and signals to be used as temporary holders.
	signal and1,and2: std_logic_vector(2 downto 0);
	signal and3:std_logic_vector(4 downto 0);
signal or1: std_logic_vector(1 downto 0);
signal a1,b1,g1,l1,greater,less,equal:std_logic;
begin -- greater = (a and not b) or (a and G) or (not b and G).
	g0:  ENTITY work.inverter2(simple) port map (a,a1); 
	gl:  ENTITY work.inverter2(simple) port map (b,b1);
	g2:  ENTITY work.and7(simple) port map (a,b1,and1(0));
	g3:  ENTITY work.and7(simple) port map (a,G,and1(1));
	g4:  ENTITY work.and7(simple) port map (b1,G,and1(2));
	g5:  ENTITY work.or7(simple) port map (and1(0),and1(1),or1(0));
	g6:  ENTITY work.or7(simple) port map (or1(0),and1(2),greater1);
	g7:  ENTITY work.inverter2(simple) port map (G,g1); 
	g8:  ENTITY work.inverter2(simple) port map (L,l1);
	--less=(not a and b) or (not a and L) or (b and L).	
	g9:  ENTITY work.and7(simple) port map (a1,b,and2(0));
	g10:  ENTITY work.and7(simple) port map (a1,L,and2(1));
	g11:  ENTITY work.and7(simple) port map (b,L,and2(2));
	g12:  ENTITY work.or7(simple) port map (and2(0),and2(1),or1(1));
	g13:  ENTITY work.or7(simple) port map (or1(1),and2(2),less1);
	--equal1=(not a and not b and not G and not L) or ( a and b and not G and not L);	
	g14:  ENTITY work.and7(simple) port map (a1,b1,and3(0));
	g15:  ENTITY work.and7(simple) port map (g1,l1,and3(1));
	g16:  ENTITY work.and7(simple) port map (and3(0),and3(1),and3(2));
	g17:  ENTITY work.and7(simple) port map (a,b,and3(3));
	g18:  ENTITY work.and7(simple) port map (and3(1),and3(3),and3(4));
	g19:  ENTITY work.or7(simple) port map (and2(2),and3(4),equal1);	
	
	
end;
-- Comparator using magnitude comparator and sign bit, compares between two inputs a,b and stores output in one of the 3 outputs, and a clock for the d-flipflops.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.ALL; 
entity nbitcomp2 is
	GENERIC ( n: POSITIVE:=8);
	port (clk:in std_logic;a,b: in std_logic_vector(n-1 downto 0);greater,equal,less:out std_logic);
end;
architecture structure of nbitcomp2 is
signal x,y:  std_logic_vector(n-1 downto 0);
signal Gr, Ls, Eq: std_logic_vector(n-1 downto 0);
signal GrT,LsT,EqT: std_logic;
begin
	gen0: for i in 0 to n-1 generate -- generating inputs from d flip flops.
		gx: entity work.DFlipFlop(behave) port map (clk,a(i),x(i));
		gy:	entity work.DFlipFlop(behave) port map (clk,b(i),y(i));
	end generate gen0;		
	Gr(0)<='0'; -- initializing the Gin and Lin to zero when they enter the comparator.
	Ls(0)<='0';	
	gen1: for i in 0 to n-2 generate -- running the inputs in the one bit comparator.
		g1:entity work.onebitcomp(structural) port map (x(i),y(i),Gr(i),Ls(i),Gr(i+1),Eq(i+1),Ls(i+1));
	end generate gen1;
	g: entity work.Equation(simple) port map (x(n-1),y(n-1),Gr(n-1),Ls(n-1),GrT,LsT,EqT);-- generate the equations from equation entity below.
	 --greater<=GrT;
	 --less<=LsT;
	 --equal<=EqT;
	 -- load all outputs into the d flip flops.
	g1:entity work.DFlipFlop port map (clk,GrT,greater);
	g2:entity work.DFlipFlop port map (clk,LsT,less);
	g3:entity work.DFlipFlop port map (clk,EqT,equal);
end;		
-- Equation entity that includes all the gates needed to generate the output from the n bit comparator
-- this entity takes 4 inputs needed to be used in the equation and produces the 3 last outputs to be put in D flip flops.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;		
entity Equation is
	port(x,y,gr,ls:in std_logic;GrT,LsT,EqT:out std_logic);
	end;
architecture simple of Equation is
signal and1: std_logic_vector(7 downto 0);
signal or1: std_logic_vector(1 downto 0);
signal x1,y1,greater,less,equal:std_logic;
begin -- Greater = (not x(7) and y(7)) or (not x(7) and not y(7) and gr) or (x(7) and y(7) and gr).
	g0:  ENTITY work.inverter2(simple) port map (x,x1); 
	g1:  ENTITY work.inverter2(simple) port map (y,y1);
	g2:  ENTITY work.and7(simple) port map (x1,y,and1(0));
	g3:  ENTITY work.and7(simple) port map (x1,y1,and1(1));
	g4:  ENTITY work.and7(simple) port map (and1(1),gr,and1(2));
	g5:  ENTITY work.and7(simple) port map (x,y,and1(3));
	g6:  ENTITY work.and7(simple) port map (and1(3),gr,and1(4));
	g7:  ENTITY work.or7(simple) port map (and1(0),and1(2),or1(0));
	g8:  ENTITY work.or7(simple) port map (or1(0),and1(4),greater);
	  -- Less = ( x(7) and not y(7)) or (not x(7) and not y(7) and ls) or (x(7) and y(7) and ls).
	g9:  ENTITY work.and7(simple) port map (x,y1,and1(5));
	g10: ENTITY work.and7(simple) port map (and1(1),ls,and1(6));
	g11: ENTITY work.and7(simple) port map (and1(3),ls,and1(7));
	g12: ENTITY work.or7(simple) port map (and1(5),and1(6),or1(1));
	g13: ENTITY work.or7(simple) port map (or1(1),and1(7),less);
		-- Equal = greater nor less.
	g14: ENTITY work.nor5(simple) port map (greater,less,equal);
	GrT<=greater;
	LsT<=less;
	EqT<=equal;
end;
-- STAGE 1:	
-- one bit adder, three 1 bit inputs (x,y to be added and cin), 2 outputs (sum of x,y and cout).		
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;		
ENTITY onebitadder IS
    PORT ( x, y, cin: IN STD_LOGIC; sum, cout: OUT STD_LOGIC);
END;
-- one bit adder architecture using simple gates.
ARCHITECTURE simple OF onebitadder Is
signal and1:std_logic_vector(2 downto 0);
signal or1,or2,xor1: std_logic;
BEGIN
	-- sum = x xor y xor cin.
	g0: entity work.xor12(simple) port map (x,y,xor1);
	g1: entity work.xor12(simple) port map (xor1,cin,sum);
	-- cout = (x and y) or (x and cin) or (y and cin).
	g2: entity work.and7(simple) port map (x,y,and1(0));
	g3: entity work.and7(simple) port map (x,cin,and1(1));
	g4: entity work.and7(simple) port map (cin,y,and1(2));
	g5: entity work.or7(simple) port map (and1(0),and1(1),or2);
	g6: entity work.or7(simple) port map (or2,and1(2),cout);	
	
END;
-- n bit subtractor, two n bit inputs (x,y to be added)and cin input which is 1 bit, 2 outputs (sum (n-bit) of x,y and cout(1-bit)),
-- and a carryPREV output to be used later in the overflow obsticle.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.ALL;
ENTITY nbitadder IS
	GENERIC ( n: POSITIVE:=8); -- Generic value initialized to 8.(8-bit).
  PORT ( x, y: IN std_logic_vector(n-1 DOWNTO 0);
          cin:  IN STD_LOGIC;
          sum: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		   cout,carryPREV: OUT STD_LOGIC);
END;
-- structural iterative architecture that uses xor gates on the second 8 bit input in order to make the circuit a subtractor(y xor cin),
-- with cin initialized to 1 in order for the circuit to become a subtractor, followed by the use of the onebitadder.
ARCHITECTURE iterative OF nbitadder IS
signal y1: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
signal carry: STD_LOGIC_vector(n downto 0);
begin
    carry(0) <= cin;
	cout <= carry(n);
	carryPREV<=carry(n-1);
	gen1: FOR i IN 0 TO n-1 GENERATE  
	     g:  entity work.xor12(simple) port map(y(i),cin,y1(i));
     end generate gen1;
    gen2: FOR i IN 0 TO n-1 GENERATE  
	     g:  entity work.onebitadder(simple) port map (x(i),y1(i),carry(i),sum(i),carry(i+1));
     end generate gen2;
END ARCHITECTURE iterative; 


--The comparator using ripple adder that takes 3 inputs (x,y to be compared and a clock for the d flip flop), and 3 outputs (greater,equal,less).	
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.ALL;
entity nbitadderCOMP is
	GENERIC ( n: POSITIVE:=8);
	port (clk:in std_logic; x,y: in std_logic_vector(n-1 downto 0);greater,equal,less:out std_logic);
end;
  -- structural implementation of the comparator using the ripple adder/subtractor and simple gates.
architecture structural of nbitadderCOMP is
signal A,B,sum: std_logic_vector(n-1 downto 0);
signal eqT: std_logic_vector(n downto 0);
signal cin,carry,carryPREV: std_logic;
signal eq: std_logic_vector(n-1 downto 0);
signal ov,lessT,ov2,greatT: std_logic;
signal eqT2,xor1: std_logic;
begin 
	gen0: for i in 0 to n-1 generate -- generating the input from the d flip flops.
		gx: entity work.DFlipFlop(behave) port map (clk,x(i),A(i));
		gy:	entity work.DFlipFlop(behave) port map (clk,y(i),B(i));
	end generate gen0;
	cin<='1'; -- initial value of the cin is 1 in order for the ripple adder to turn into a subtractor.
	eqT(0)<='0'; -- equal Temp that will go into the OR gates made for the equal value.
	   g:  ENTITY work.nbitadder(iterative) 
       PORT MAP (A,B,cin,sum,carry,carryPREV);
	   eq<=sum; -- another equal Temp that takes the values of the sum to be used below in the or gate generator.
	   gen1: FOR i IN 0 TO n-1 GENERATE	-- or gate generator that compares all the sum bits to see if they all are Zeros.
	     g:  ENTITY work.or7(simple) port map (eqT(i),eq(i),eqT(i+1)); 
      END GENERATE gen1;
	  g1:  ENTITY work.inverter2(simple) port map (eqT(n),eqT2);-- equal temp 2 = value from or gates above.
	  --equal<=eqT2;
	  g2:  ENTITY work.xor12(simple) port map (carry,carryPREV,ov);-- overflow = carry xor carryPREV
	  g3: entity work.xor12(simple) port map (ov,sum(n-1),xor1);  -- overflow xor sum last bit
	  g4: entity work.and7(simple) port map (xor1,eqT(n),LessT); -- overflow xor sum(7) and not equal (eqT(n) = not equal).	   
	  --less<=lessT;
	  g5: entity work.nor5(simple) port map (lessT,eqT2,greatT); -- greater = less nor equal.
	  --greater<= greatT;
	  -- Load the outputs into D flip flops.
	  g6:entity work.DFlipFlop port map (clk,greatT,greater);
	  g7:entity work.DFlipFlop port map (clk,lessT,less);
	  g8:entity work.DFlipFlop port map (clk,eqT2,equal);
end;
	   
 -- STAGE 2 TESTBENCH.
LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_ARITH.ALL;
 use ieee.std_logic_signed.ALL;
entity testBench is
    GENERIC ( n: POSITIVE:=8);
end entity;

architecture test of testBench is
-- Signals to be used in the structural maps below.
    signal clk : std_logic := '1'; -- clock for edge rising.
    signal A,B : std_logic_vector (n-1 downto 0);
    signal greaterEX,equalEX,lessEX : std_logic;	
	signal greater,equal,less : std_logic;	
begin
	clk <= NOT clk AFTER 400 NS;  -- all share the same clock, synchronization is closer this way.
	g: entity work.test_generator(tb)  port map (clk,A,B,greaterEX,equalEX,lessEX); -- test generator structural.
	g1: entity work.nbitcomp2(structure) port map (clk,A,B,greater,equal,less);	  -- n bit comp
	g2: entity work.resultAnalyzer(tb) port map (clk,A,B,greaterEX,equalEX,lessEX,greater,equal,less); -- result analyzer	
end;
-- STAGE 1 TESTBENCH
LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_ARITH.ALL;
 use ieee.std_logic_signed.ALL;
entity testBench2 is
    GENERIC ( n: POSITIVE:=8);
end entity;

architecture test of testBench2 is
-- Signals to be used in the structural maps below.
    signal clk : std_logic := '1';
    signal A,B : std_logic_vector (n-1 downto 0);
    signal greaterEX,equalEX,lessEX : std_logic;	
	signal greater,equal,less : std_logic;	
begin
	clk <= NOT clk AFTER 220 NS; -- all share the same clock, synchronization is closer this way.
	g: entity work.test_generator(tb)  port map (clk,A,B,greaterEX,equalEX,lessEX);
	g1: entity work.nbitaddercomp(structural) port map (clk,A,B,greater,equal,less);
	g2: entity work.resultAnalyzer(tb) port map (clk,A,B,greaterEX,equalEX,lessEX,greater,equal,less);	
end;
library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.STD_LOGIC_ARITH.ALL;
 use IEEE.math_real.all;
 use ieee.std_logic_signed.ALL;
 -- test generator that produces all expected results (true results).
entity test_generator is
		  GENERIC ( n: POSITIVE:=8);
 PORT ( clock: in STD_LOGIC; TestIn1: out STD_LOGIC_VECTOR(n-1 downto 0);
 TestIn2: out STD_LOGIC_VECTOR(n-1 downto 0);
 GreaterExpectedResult: out STD_LOGIC;EqualExpectedResult: out STD_LOGIC;LessExpectedResult: out STD_LOGIC);
 end;
architecture tb OF test_generator IS
 begin
	 process
	 begin
		 
		for i IN -128 TO 127 loop -- loop through all inputs
			WAIT until rising_edge(clock); -- one wait statment here
		 FOR j IN -128 TO 127 loop
			 WAIT until rising_edge(clock); -- another wait
		 TestIn1 <= CONV_STD_LOGIC_VECTOR(i,n); -- convert i so testIN1 can take the value.
		 TestIn2 <= CONV_STD_LOGIC_VECTOR(j,n);
		 WAIT until rising_edge(clock);	-- two waits statments here in order for the expected result to synchronize with flip flops delays.
		 WAIT until rising_edge(clock);
		 if (i > j) then -- doing the comparison process
			 GreaterExpectedResult <= '1';
			 EqualExpectedResult <= '0';
			 LessExpectedResult <= '0';
		 elsif(i=j)then
			GreaterExpectedResult <= '0';
			 EqualExpectedResult <= '1';
			 LessExpectedResult <= '0';
		 elsif (i<j  ) then
			GreaterExpectedResult <= '0';
			 EqualExpectedResult <= '0';
			 LessExpectedResult <= '1';
			 
		 	-- WAIT until rising_edge(clock);
		 end if;
		 END LOOP;
		 END LOOP;
		 WAIT;
	 END PROCESS;
	 END ARCHITECTURE tb;

 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_ARITH.ALL;
 -- a result analyzer that takes the output from the test generater along with the ones from the implemented comparator, and compares if they are the same
	 -- if not, an error message is shown.
 ENTITY resultAnalyzer IS
	 GENERIC ( n: POSITIVE:=8); 
	 PORT ( clock: IN STD_LOGIC; TestIn1: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); TestIn2: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
 GreaterExpectedResult: in STD_LOGIC;EqualExpectedResult: in STD_LOGIC;LessExpectedResult: in STD_LOGIC;
ActualGreater: in STD_LOGIC;ActualEqual: in STD_LOGIC;ActualLess: in STD_LOGIC);
 end;
 ARCHITECTURE tb OF resultAnalyzer IS
 BEGIN
 PROCESS(clock) -- if the clock changes (rising edge)
 BEGIN
 IF rising_edge(clock) THEN
 -- Check whether adder output matches expectation 
 ASSERT GreaterExpectedResult = ActualGreater
 and LessExpectedResult = ActualLess and EqualExpectedResult= ActualEqual
 REPORT "Something is wrong with the Results" -- error message 
 SEVERITY WARNING;
 END IF;
 END PROCESS;
 END ARCHITECTURE tb;
 


