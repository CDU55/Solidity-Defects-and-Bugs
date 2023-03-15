# Solidity-Defects-and-Bugs
This repository contains a smart contract test suite which targets the defects descriebed in [Review of Automated Vulnerability Analysis of Smart Contracts on Ethereum](https://www.frontiersin.org/articles/10.3389/fbloc.2022.814977/full), Table 6.

## The defects incluced in this repository are the following:

1. **Malicious Environment, Transactions or Input**
- Reentrancy
- Call to the unknown
- Exact balance dependency
- Improper data validation
- Vulnerable DELEGATECALL
2. **Blockchain/Environment Dependency**
- Timestamp dependency
- Transaction-ordering dependency (TOD)
- Bad random number generation
- Leakage of confidential information
- Unpredictable state (dynamic libraries)
- Blockhash dependency
3. **Exception & Error Handling Disorders**
- Unchecked low level call/send return values
- Unexpected throw or revert
- Mishandled out-of-gas exception
- Assert, require or revert violation
4. **Denial of Service**
- Frozen Ether
- Ether lost in transfer
- DoS with block gas limit reached
- DoS by exception inside loop
- Insufficient gas griefing
5. **Resource Consumption & Gas Issues**
- Gas costly loops
- Gas costly pattern
- High gas consumption of variable data type or declaration
- High gas consumption function type
- Under-priced opcodes
6. **Authentication & Access Control Vulnerabilities**
- Authorization via transaction origin
- Unauthorized accessibility due to wrong function or state variable visibility
- Unprotected self-destruction
- Unauthorized Ether withdrawal
- Signature based vulnerabilities
7. **Arithmetic Bugs**
- <s>Integer over- or underflow</s>
- Integer division
- Integer bugs or arithmetic issues
8. **Bad Coding and Language Specifics**
- Type cast
- <s>Coding error</s>
- <s>Bad coding pattern</s>
- Deprecated source language features
- <s>Write to arbitrary storage location</s>
- Use of assembly
- <s>Incorrect inheritance order</s>
- Variable shadowing
- <s>Misleading source code</s>
- <s>Missing logic</s> , <s>logical errors</s> or dead code
- <s>Insecure contract upgrading</s>
- Inadequate or incorrect logging or <s>documentation</s>
9. **Environment Configuration Issues**
- Short address
- Outdated compiler version
- Floating or no pragma
- Token API violation
- <s>Ethereum update incompatibility</s>
- <s>Configuration error </s>
10. **Eliminated/Deprecated Vulnerabilities**
- Callstack depth limit
- <s>Uninitialized storage pointer</s>
- Erroneous constructor name