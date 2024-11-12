library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;
use work.util_sim.all;

entity sim_ram_256x32 is
end sim_ram_256x32;

architecture sim of sim_ram_256x32 is
  component ram_256x32 is
    port (
      clk_w : in  std_logic;
      dir_w : in  std_logic_vector(7 downto 0);
      hab_w : in std_logic;
      dat_w : in std_logic(31 downto 0);
      clk_r : in std_logic;
      dir_r : in std_logic_vector(7 downto 0);
      hab_r : in std_logic;
      dat_r : out std_logic_vector(31 downto 0)
      );
  end component; -- ram_256x32
  signal dir : std_logic_vector(7 downto 0);
  signal dat_w : std_logic_vector(31 downto 0); 
  signal dat_r : std_logic_vector(31 downto 0);
  signal hab_r, hab_w, clk: std_logic;
begin
  -- Dispositivo bajo prueba
  dut : ram_256x32 port map (A=>entradas(1),B=>entradas(0),Y=>salida);

  excitaciones: process
  begin
    for i in 0 to (2**entradas'length)-1 loop
      entradas <= std_logic_vector(to_unsigned(i,entradas'length));
      wait for 1 ns;
    end loop;
    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
