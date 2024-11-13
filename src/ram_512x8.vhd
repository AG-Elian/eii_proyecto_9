library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_512x8 is
  port (
    clk_w : in  std_logic;
    dir_w : in  std_logic_vector(8 downto 0);
    hab_w : in std_logic;
    dat_w : in std_logic_vector(7 downto 0);
    clk_r : in std_logic;
    dir_r : in std_logic_vector(8 downto 0);
    hab_r : in std_logic;
    dat_r : out std_logic_vector(7 downto 0)
  );
end ram_512x8;

architecture behavioral of ram_512x8 is
  type mem_t is array(0 to 511) of std_logic_vector(7 downto 0);
  signal mem : mem_t:=(7=>x"AA", others=>x"00");
begin
  read_port : process (clk_r)
  begin
    if rising_edge(clk_r) then
      if hab_r = '1' then
        dat_r <= mem(to_integer(unsigned(dir_r)));
      end if;
    end if;
  end process;

  write_port : process(clk_w)
  begin
    if rising_edge(clk_w) then
      if hab_w = '1' then
        mem(to_integer(unsigned(dir_w)))<=dat_w;
        end if;
    end if;
  end process;

end behavioral;
