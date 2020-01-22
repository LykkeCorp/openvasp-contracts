const { contract } = require('@openzeppelin/test-environment');
const { expect } = require('chai');

const VASPMock = contract.fromArtifact('VASP');

describe('VASP', function() {

    describe('deployment', function() {

        it('does not revert', function() {
            expect(async function() { await VASPMock.new() }).to.not.throw();
        });

    });

    describe('after deployment', function() {

        beforeEach(async function () {
            this.contract = await VASPMock.new();
        });

        describe('initially', function() {

            it('channels list is empty', async function() {
                expect((await this.contract.channels())).to.be.empty;
            });

            it('code is valid', async function() {
                const lastAddressBytes = this.contract.address.substring(this.contract.address.length - 8);
                expect(await this.contract.code()).to.be.equal(`0x${lastAddressBytes.toLowerCase()}`);
            });

            it('email is empty', async function() {
                expect((await this.contract.email())).to.be.empty;
            });

            it('handshake key is empty', async function() {
                expect((await this.contract.handshakeKey())).to.be.empty;
            });

            it('identity claims list is empty', async function() {
                expect((await this.contract.identityClaimsCount())).to.be.bignumber.equal('0');
            });

            it('name is empty', async function() {
                expect((await this.contract.name())).to.be.empty;
            });

            describe('postal address', function() {

                let postalAddress;

                beforeEach(async function() {
                    postalAddress = await this.contract.postalAddress();
                });

                it('street name is empty', async function() {
                    expect(postalAddress.streetName).to.be.empty;
                });

                it('building number is empty', async function() {
                    expect(postalAddress.buildingNumber).to.be.empty;
                });

                it('address line is empty', async function() {
                    expect(postalAddress.addressLine).to.be.empty;
                });

                it('post code is empty', async function() {
                    expect(postalAddress.postCode).to.be.empty;
                });

                it('town is empty', async function() {
                    expect(postalAddress.town).to.be.empty;
                });

                it('country is empty', async function() {
                    expect(postalAddress.country).to.be.empty;
                });

            });

            it('signing key is empty', async function() {
                expect((await this.contract.signingKey())).to.be.empty;
            });

            it('trusted peers list is empty', async function() {
                expect((await this.contract.trustedPeersCount())).to.be.bignumber.equal('0');
            });

            it('website is empty', async function() {
                expect((await this.contract.handshakeKey())).to.be.empty;
            });

        });

        describe('during initialization', function() {
            //TODO: Add tests
        });

        describe('after initialization', function() {
            //TODO: Add tests
        });
    });

});