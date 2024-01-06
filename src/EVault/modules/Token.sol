// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity ^0.8.0;

import {IToken, IERC20} from "../IEVault.sol";
import {Base} from "../shared/Base.sol";
import {BalanceUtils} from "../shared/BalanceUtils.sol";
import {ProxyUtils} from "../shared/lib/ProxyUtils.sol";
import {RevertBytes} from "../shared/lib/RevertBytes.sol";

import "../shared/types/Types.sol";

abstract contract TokenModule is IToken, Base, BalanceUtils {
    using TypesLib for uint256;

    /// @inheritdoc IERC20
    function name() external view virtual reentrantOK returns (string memory) {
        (, IRiskManager riskManager) = ProxyUtils.metadata();

        return riskManager.marketName(address(this));
    }

    /// @inheritdoc IERC20
    function symbol() external view virtual reentrantOK returns (string memory) {
        (, IRiskManager riskManager) = ProxyUtils.metadata();

        return riskManager.marketSymbol(address(this));
    }

    /// @inheritdoc IERC20
    function decimals() external view virtual reentrantOK returns (uint8) {
        (IERC20 asset_,) = ProxyUtils.metadata();

        return asset_.decimals();
    }

    /// @inheritdoc IERC20
    function totalSupply() external view virtual nonReentrantView returns (uint256) {
        return loadMarket().totalBalances.toUint();
    }

    /// @inheritdoc IERC20
    function balanceOf(address account) external view virtual nonReentrantView returns (uint256) {
        return marketStorage.users[account].balance.toUint();
    }

    /// @inheritdoc IERC20
    function allowance(address holder, address spender) external view virtual nonReentrantView returns (uint256) {
        return marketStorage.eVaultAllowance[holder][spender];
    }
}

contract Token is TokenModule {
    constructor(address evc) Base(evc) {}
}