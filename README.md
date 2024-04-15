# extractFunctionArgumentValidation

This function allows you to extract the information of input/output function argument validation from outside the function.  

## Usage

You can use the ***extractFunctionArgumentValidation*** function as below:
```matlab
filename   = "myFileName.m";
funcArgVal = extractFunctionArgumentValidation(filename);
```
  
You can specify which block you want to gather the information from: *Input* (by default), *Output* or *All*. 
```matlab
filename   = "myFileName.m";
funcArgVal = extractFunctionArgumentValidation(filename, "All");
```
  
Open and run the ***run.mlx*** live script MATLAB file to see an example.

## Content

- **extractFunctionArgumentValidation.m**: Main function used to call the *extractBlockFunction* function 
- **extractBlockFunction.m**:              Function used by the *extractFunctionArgumentValidation* function to extract information form outside the targeted function
- **plan folder**:                         Plan containing tests
  
## Roadmap
- [ ] Test compatibility between I/O of 2 functions 



