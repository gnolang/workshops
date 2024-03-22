const { VITE_CHAIN_ID, VITE_CHAIN_RPC, VITE_REALM_PATH } = import.meta.env;

if (!VITE_CHAIN_ID) {
  throw new Error('VITE_CHAIN_ID property not found in .env');
}

if (!VITE_CHAIN_RPC) {
  throw new Error('VITE_CHAIN_RPC property not found in .env');
}

if (!VITE_REALM_PATH) {
  throw new Error('VITE_REALM_PATH property not found in .env');
}

export default {
  CHAIN_ID: VITE_CHAIN_ID,
  CHAIN_RPC: VITE_CHAIN_RPC,
  REALM_PATH: VITE_REALM_PATH
};
