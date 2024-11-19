library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;
use work.util_sim.all;

entity sim_reg_32x32 is
end sim_reg_32x32;

architecture sim of sim_reg_32x32 is
  component reg_32x32 is
    port (
      clk, hab_w: in  std_logic;
      dir_w, dir_r1, dir_r2 : in  std_logic_vector(4 downto 0);
      dat_w : in std_logic_vector(31 downto 0);
      dat_r1, dat_r2 : out std_logic_vector(31 downto 0)
    );
  end component; -- reg_32x32

  signal dir,dir_r1,dir_r2 : std_logic_vector(4 downto 0);
  signal dat_w : std_logic_vector(31 downto 0); 
  signal dat_r1, dat_r2 : std_logic_vector(31 downto 0);
  signal hab_w, clk: std_logic;
begin
  -- Dispositivo bajo prueba
  dut : reg_32x32 port map (clk=>clk,dir_w=>dir,dir_r1=>dir_r1,dir_r2=>dir_r2,dat_w=>dat_w,dat_r1=>dat_r1,dat_r2=>dat_r2,hab_w=>hab_w);

  reloj: process
    begin
      clk<='0';
      wait for 1 ns;
      clk<='1';
      wait for 1 ns;
      end process;
  excitaciones: process
  
  variable aleatorio : aleatorio_t;
    procedure sig_ciclo is
      begin
        wait until rising_edge(clk);
        wait for 0.5 ns;
        end procedure;
  begin
    for k in 0 to 10 loop
      dir <= aleatorio.genera_vector(5);
      dat_w <= (others=>'0');
      hab_w <= '1';
      sig_ciclo;
      dat_w <= aleatorio.genera_vector(32);
      hab_w <= aleatorio.genera_bit;
      sig_ciclo;
      hab_w <= '0';
      sig_ciclo;
      end loop;
      sig_ciclo;
      finish;
  end process; -- excitaciones
end sim;
