library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_ram_512x8 is
end sim_ram_512x8;

architecture sim of sim_ram_512x8 is
  component ram_512x8 is
    port (
      clk_w : in  std_logic;
      dir_w : in  std_logic_vector(8 downto 0);
      hab_w : in std_logic;
      dat_w : in std_logic(7 downto 0);
      clk_r : in std_logic;
      dir_r : in std_logic_vector(8 downto 0);
      hab_r : in std_logic;
      dat_r : out std_logic_vector(7 downto 0)
    );
  end component; -- ram_512x8
  signal dir_r, dir_w : std_logic_vector(8 downto 0);
  signal dat_w : std_logic_vector(7 downto 0); 
  signal dat_r : std_logic_vector(7 downto 0);
  signal hab_r, hab_w, clk_r, clk_w : std_logic;
begin
  -- Dispositivo bajo prueba
  dut : ram_512x8 port map (clk_w=>clk_w,clk_r=>clk_r,dat_r=>dat_r,
                      dat_w=>dat_w, hab_r=>hab_r,hab_w=>hab_w,dir_r=>dir_r,dir_w=>_dir_w);

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
