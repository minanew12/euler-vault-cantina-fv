// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity ^0.8.0;

import {Base} from "../shared/Base.sol";
import {ILiquidation} from "../IEVault.sol";

import "../shared/types/Types.sol";

abstract contract LiquidationModule is ILiquidation, Base {

}

contract Liquidation is LiquidationModule {
    constructor(address factory, address cvc) Base(factory, cvc) {}
}