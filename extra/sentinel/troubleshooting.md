![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/1e0ce2a3-5a3f-42e4-89de-78cac1f95e28)

## Fork GitHub Repository

- Create a repository to host the policy configuration:
- Declare a policy with `sentinel.hcl` file.
- Define a policy with `allowed-terraform-version.sentinel` 

## Connect the Policy to Terraform Cloud

I attempted many times to complete a Terraform tutorial for enforcing policies in both AWS and Azure.

Enforcing a policy requires a policy set and the tutorial also requires for the policy set to be stored in a Version Control Provider's repository.  

It turns out that the free version of Terraform CLoud does not allow connections to policy sets in Version Control providers such as Github. An attempt to choose a provider leads to this error message: 

***There are no remaining versioned policy sets that can be created in this organization.***

I will have to ccome back to sentinels when I have access to paid edition of Terraform!

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/699c88a1-392c-4a36-ba9b-637f1bb6108e)


