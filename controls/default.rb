#
# inspec_profile::azurerm-key-vault
# controls::default
#
# author:cloudsquad@fxinnovation.com
# description: Controls for Key Vault in Azure
#

###
# Controls
###
control 'key_vault' do
    impact 1.0
    title  'Checks the azure key vault'
    tag    'azurerm'
    tag    'key_vault'

    only_if('module is disabled') do
        input('enabled')
    end

    describe azure_generic_resource(
        group_name: input('resource_group_name'),
        name: input('name')
    ) do
        it                   { should have_tags }
        its('location')      { should cmp input('location') }
        its('tags')          { should include "Terraform" }
        its('Terraform_tag') { should cmp "true"}
    end

end
