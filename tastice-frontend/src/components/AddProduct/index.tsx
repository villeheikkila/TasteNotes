import React, { useState } from "react";
import { ADD_PRODUCT, ALL_PRODUCTS } from "../../queries";
import { useMutation } from "@apollo/react-hooks";
import { notificationHandler, errorHandler } from "../../utils";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import Grid from "@material-ui/core/Grid";
import TextField from "@material-ui/core/TextField";
import { MaterialSelect } from "./MaterialSelect";
import { OptionType } from "../../types";

const companies: OptionType[] = [
  { label: "Coca Cola Co" },
  { label: "Pepsi Co" },
  { label: "Hartwall" },
  { label: "Olvi" },
  { label: "Fentimans" }
].map(suggestion => ({
  value: suggestion.label,
  label: suggestion.label
}));

const categories: OptionType[] = [
  { label: "Soda" },
  { label: "Coffee" },
  { label: "Noodles" },
  { label: "Pizza" },
  { label: "Juice" }
].map(suggestion => ({
  value: suggestion.label,
  label: suggestion.label
}));

const subCategories: OptionType[] = [
  { label: "Tea" },
  { label: "Mead" },
  { label: "Energy Drink" },
  { label: "Sports drink" },
  { label: "Sparkling Water" }
].map(suggestion => ({
  value: suggestion.label,
  label: suggestion.label
}));

const useStyles = makeStyles(theme => ({
  paper: {
    padding: theme.spacing(3, 2),
    maxWidth: 700,
    margin: `${theme.spacing(1)}px auto`,
    display: "flex",
    flexDirection: "column"
  },
  button: {
    margin: theme.spacing(1)
  },
  root: {
    paddingTop: 30
  },
  textField: {
    marginTop: 15,
    width: "100%"
  }
}));

export const AddProduct = () => {
  const classes = useStyles();
  const [name, setName] = useState("");
  const [producer, setProducer] = useState();
  const [category, setCategory] = useState();
  const [subCategory, setSubCategory] = useState();
  const [addProduct] = useMutation(ADD_PRODUCT, {
    onError: errorHandler,
    refetchQueries: [{ query: ALL_PRODUCTS }]
  });

  if (addProduct === null) {
    return null;
  }

  const handleNameChange = (event: any) => setName(event.target.value);

  const handleProducerChange = (value: any) => setProducer(value);

  const handleCategoryChange = (value: any) => setCategory(value);

  const handleSubCategoryChange = (value: any) => setSubCategory(value);

  const handleAddProduct = async (event: any) => {
    event.preventDefault();

    const result = await addProduct({
      variables: { name, producer: producer.value, type: category.value }
    });

    if (result) {
      notificationHandler({
        message: `Product ${result.data.addProduct.name} succesfully added`,
        variant: "success"
      });
    }
  };

  return (
    <div className={classes.root}>
      <Paper className={classes.paper}>
        <Typography component="h1" variant="h5">
          Add a new product!
        </Typography>

        <form onSubmit={handleAddProduct}>
          <TextField
            id="Name"
            label="Name"
            name="Name"
            placeholder="Name of the product"
            value={name}
            onChange={handleNameChange}
            className={classes.textField}
          />
          <Grid
            container
            alignContent={"center"}
            alignItems={"center"}
            spacing={2}
          >
            <Grid item xs={12} sm={6} />
            <Grid item xs={12}>
              <MaterialSelect
                isCreatable={true}
                isMulti={false}
                suggestions={companies}
                label={"Producer"}
                placeholder={"Select a company"}
                onChange={handleProducerChange}
                value={producer}
              />
              <MaterialSelect
                isCreatable={false}
                isMulti={false}
                suggestions={categories}
                label={"Category"}
                placeholder={"Select a category"}
                onChange={handleCategoryChange}
                value={category}
              />
              <MaterialSelect
                isCreatable={true}
                isMulti={true}
                suggestions={subCategories}
                label={"Subcategory"}
                placeholder={"Select a subcategory or a create a new one"}
                onChange={handleSubCategoryChange}
                value={subCategory}
              />
            </Grid>
            <Grid item xs={12}>
              <Button
                type="submit"
                variant="contained"
                color="secondary"
                className={classes.button}
              >
                Add Product!
              </Button>
            </Grid>
          </Grid>
        </form>
      </Paper>
    </div>
  );
};
