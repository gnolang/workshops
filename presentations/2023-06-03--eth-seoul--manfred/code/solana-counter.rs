// minimized version of the code available at:
// https://github.com/morimolymoly/countertest/blob/main/programs/countertest/src/lib.rs
use anchor_lang::{prelude::*, solana_program::system_program};
use anchor_spl::token::{self, SetAuthority, Token, TokenAccount, Transfer, MintTo, mint_to, Mint};
declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");
#[program]
pub mod countertest {
    use super::*;
    pub fn test_pda_init(ctx: Context<TestPdaInit>, _domain: String, _seed: Vec<u8>, _bump: u8) -> ProgramResult {
        ctx.accounts.my_pda.counter = 0; Ok(())
    }
    pub fn test_pda_inc(ctx: Context<TestPdaInc>, _a: i64) -> ProgramResult {
        ctx.accounts.my_pda.counter += 1; // HL
        Ok(())
    }
}
#[account]
#[derive(Default)]
pub struct CounterData { pub counter: i64 }
#[derive(Accounts)]
pub struct TestPdaInc<'info> {
    #[account(mut)]
    pub my_pda: Account<'info, CounterData>
}
// ...
