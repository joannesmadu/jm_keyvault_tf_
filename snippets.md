for memory:

- To set the terraform project or update provider/backend dependencies:
`terraform init`

- To validate terraform code:
`terraform validate`

- To create a plan of what would change but only see it on the screen:
`terraform plan`

- To create a plan of what would change and save the plan to a file:
`terraform plan -out=my_plan.tfplan`

- To plan show what plan would be on screen + if agree apply it:
`terraform apply`

- To apply a plan that you created beforehand:
`terraform apply my_plan.tfplan`

- To get the output of the last deployment:
`terraform output`

- To delete all resources that were deployed with present project/folder:
`terraform destroy`

- Adding variables to your command
  - `terraform plan -out=my_plan.tfplan -var cohort=6 -var string_length=10`
    - create plan for changes, save plan to file whilst hard-coding variables
  - `terraform apply -var cohort=6 -var string_length=10`
    - show what plan would be on screen, whilst hard-coding variables
  - `terraform apply -var-file="variable_values.tfvars"`
    - show plan on screen while NOT hard-coding variables

- Docs `terraform-docs markdown . > documentation.md`
