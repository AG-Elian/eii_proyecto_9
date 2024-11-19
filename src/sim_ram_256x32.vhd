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
  dut : ram_256x32 port map (clk_w=>clk,clk_r=>clk,dat_w=>dat_w,hab_r=>'1',hab_w=>hab_w,dat_r=>dat_r,dir_r=dir,dir_w=>dir);
  
  reloj: process --Definicion del proceso de reloj(clk)
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
      dir <= aleatorio.genera_vector(8);
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
