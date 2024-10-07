module MyModule::TreePlantingInitiative {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::vector;

    /// Struct representing a tree planting record.
    struct TreePlantingRecord has store, key {
        description: vector<u8>,  // Description or proof of planting (e.g., location, photo metadata)
        is_verified: bool,        // Whether the tree planting has been verified
    }

    /// Function to submit a proof of planting a tree.
    public fun submit_proof(planter: &signer, description: vector<u8>) {
        let record = TreePlantingRecord {
            description,
            is_verified: false,  // Initially not verified
        };
        move_to(planter, record);
    }

    /// Function to verify tree planting and reward the planter.
    public fun verify_and_reward(reward_pool: &signer, planter_address: address, reward_amount: u64) acquires TreePlantingRecord {
        let record = borrow_global_mut<TreePlantingRecord>(planter_address);

        // Ensure the tree planting record has not been verified already
        assert!(!record.is_verified, 1);

        // Set the record as verified
        record.is_verified = true;
    }
}
