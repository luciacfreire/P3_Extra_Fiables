----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2025 10:58:54
-- Design Name: 
-- Module Name: tb_redundancia - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_redundancia is
end tb_redundancia;

architecture behavior of tb_redundancia is
    -- Component declaration
    component redundancia
        Generic ( SIMULATION_MODE : boolean := false );
        Port (
            CLK100MHZ : in STD_LOGIC;
            RESET : in STD_LOGIC;
            SW : in STD_LOGIC_VECTOR (0 downto 0);
            LED : out STD_LOGIC_VECTOR (7 downto 0);
            LED_CONTADOR_1 : out STD_LOGIC;
            LED_CONTADOR_2 : out STD_LOGIC;
            AN : out STD_LOGIC_VECTOR (7 downto 0);
            SEG : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Testbench signals
    signal CLK100MHZ_tb : STD_LOGIC := '0';
    signal RESET_tb : STD_LOGIC := '0';
    signal SW_tb : STD_LOGIC_VECTOR(0 downto 0) := "0";
    signal LED_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal LED_CONTADOR_1_tb : STD_LOGIC;
    signal LED_CONTADOR_2_tb : STD_LOGIC;
    signal AN_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal SEG_tb : STD_LOGIC_VECTOR(6 downto 0);

    constant clk_period : time := 10 ns;  -- 100 MHz

begin
    -- Instancia del DUT (Device Under Test)
    UUT: redundancia
        generic map(SIMULATION_MODE => true)
        port map(
            CLK100MHZ => CLK100MHZ_tb,
            RESET => RESET_tb,
            SW => SW_tb,
            LED => LED_tb,
            LED_CONTADOR_1 => LED_CONTADOR_1_tb,
            LED_CONTADOR_2 => LED_CONTADOR_2_tb,
            AN => AN_tb,
            SEG => SEG_tb
        );

    -- Reloj de 100 MHz
    clk_process : process
    begin
        while now < 5 ms loop
            CLK100MHZ_tb <= '0';
            wait for clk_period / 2;
            CLK100MHZ_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Reset inicial
        RESET_tb <= '1';
        wait for 100 ns;
        RESET_tb <= '0';

        -- Contador1 activo por defecto
        wait for 5 ms;

        -- Cambiar al contador2
        SW_tb <= "1";
        wait for 5 ms;

        -- Terminar simulación
        wait;
    end process;

end behavior;

