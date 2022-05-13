# Git-Tools
A series of tools to help increase your GitHub productivity.

## Tools List
### compare.sh
* Example Usage: `./compare.sh branch_to_merge_to`
* Will compare branch passed in argument against current branch
* Args: 
    * `comparison_branch`: Branch to Compare Against
    * `mode` (optional): Reverse Comparison
        * `normal` (default): comparison_branch <- current_branch
        * `reverse`: current_branch <- comparison_branch
        * `custom`: comparison_branch <- second_branch
    * `second_branch` (only when arg `mode=custom`):
        * Branch to Compare Against
        * comparison_branch <- second_branch

### helper.sh
* Helper Functions, Used In Other Tools