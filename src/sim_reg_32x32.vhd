library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_reg_32x32 is
end sim_reg_32x32;

architecture sim of sim_reg_32x32 is
  component reg_32x32 is
    port (
      clk, hab_w : in  std_logic;
      dir_w, dir_r1, dir_r2 : in  std_logic_vector(4 downto 0);
      dat_w : in std_logic_vector(3 downto 0);
      dat_r1, dat_r2 : out std_logic_vector(3 downto 0)
    );
  end component; -- reg_32x32
  signal entradas : std_logic_vector (1 downto 0);
  signal salida : std_logic;
begin
  -- Dispositivo bajo prueba
  dut : reg_32x32 port map (A=>entradas(1),B=>entradas(0),Y=>salida);

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
