-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Project
-- Author      : Ibrahim Nobani
-- Company     : Ibrahim
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Project\compile\Project-Diagram.vhd
-- Generated   : Sun Dec 26 10:55:58 2021
-- From        : c:\My_Designs\Project\src\Project-Diagram.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity \Project-Diagram\ is
  port(
       A : in STD_LOGIC;
       B : in STD_LOGIC;
       Gr0 : in STD_LOGIC := 0;
       Ls0 : in STD_LOGIC := 0;
       A1 : in STD_LOGIC;
       B1 : in STD_LOGIC;
       A2 : in STD_LOGIC;
       B2 : in STD_LOGIC;
       A3 : in STD_LOGIC;
       B3 : in STD_LOGIC;
       A4 : in STD_LOGIC;
       B4 : in STD_LOGIC;
       A5 : in STD_LOGIC;
       B5 : in STD_LOGIC;
       A6 : in STD_LOGIC;
       B6 : in STD_LOGIC;
       A7 : in STD_LOGIC;
       B7 : in STD_LOGIC;
       Output1 : out STD_LOGIC;
       Output2 : out STD_LOGIC;
       Output3 : out STD_LOGIC
  );
end \Project-Diagram\;

architecture \Project-Diagram\ of \Project-Diagram\ is

---- Component declarations -----

component onebitcomp
  port(
       a : in STD_LOGIC;
       b : in STD_LOGIC;
       G : in STD_LOGIC;
       L : in STD_LOGIC;
       greater1 : out STD_LOGIC;
       equal1 : out STD_LOGIC;
       less1 : out STD_LOGIC
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal NET162 : STD_LOGIC;
signal NET170 : STD_LOGIC;
signal NET178 : STD_LOGIC;
signal NET186 : STD_LOGIC;
signal NET194 : STD_LOGIC;
signal NET202 : STD_LOGIC;
signal NET210 : STD_LOGIC;
signal NET218 : STD_LOGIC;
signal NET238 : STD_LOGIC;
signal NET300 : STD_LOGIC;
signal NET306 : STD_LOGIC;
signal NET347 : STD_LOGIC;
signal NET351 : STD_LOGIC;

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

----  Component instantiations  ----

U10 : onebitcomp
  port map(
       a => A7,
       b => B7,
       G => NET347,
       L => NET351,
       greater1 => Output1,
       equal1 => Output2,
       less1 => Output3
  );

U2 : onebitcomp
  port map(
       a => A,
       b => B,
       G => Gr0,
       L => Ls0,
       greater1 => NET162,
       less1 => NET170
  );

U4 : onebitcomp
  port map(
       a => A1,
       b => B1,
       G => NET162,
       L => NET170,
       greater1 => NET178,
       less1 => NET186
  );

U5 : onebitcomp
  port map(
       a => A2,
       b => B2,
       G => NET178,
       L => NET186,
       greater1 => NET194,
       less1 => NET202
  );

U6 : onebitcomp
  port map(
       a => A3,
       b => B3,
       G => NET194,
       L => NET202,
       greater1 => NET210,
       less1 => NET218
  );

U7 : onebitcomp
  port map(
       a => A4,
       b => B4,
       G => NET210,
       L => NET218,
       greater1 => NET238
  );

U8 : onebitcomp
  port map(
       a => A5,
       b => B5,
       G => NET238,
       L => Dangling_Input_Signal,
       greater1 => NET300,
       less1 => NET306
  );

U9 : onebitcomp
  port map(
       a => A6,
       b => B6,
       G => NET300,
       L => NET306,
       greater1 => NET347,
       less1 => NET351
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end \Project-Diagram\;
