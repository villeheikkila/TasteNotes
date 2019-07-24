import React from 'react';
import { ProductCard } from '../ProductCard';
import { Product } from '../../types';
import { useQuery } from '@apollo/react-hooks';
import { ALL_PRODUCTS } from '../../queries';
import useReactRouter from 'use-react-router';

import AddIcon from '@material-ui/icons/Add';
import { Grid, Fab, makeStyles, Card } from '@material-ui/core';

const useStyles = makeStyles(theme => ({
    root: {
        flexGrow: 1,
        overflow: 'hidden',
        maxWidth: 700,
        margin: `${theme.spacing(1)}px auto`,
        alignContent: 'center',
    },
    card: {
        margin: `${theme.spacing(1)}px auto`,
    },
    fab: {
        margin: 0,
        top: 'auto',
        right: 30,
        bottom: 70,
        position: 'fixed',
    },
}));

export const ProductView = () => {
    const classes = useStyles();
    const productsQuery = useQuery(ALL_PRODUCTS);
    const products = productsQuery.data.products;
    const { history } = useReactRouter();

    if (products === undefined) {
        return null;
    }

    return (
        <div className={classes.root}>
            <Grid container justify="center" spacing={10}>
                <Grid item xs={12}>
                    {products.map((product: Product) => (
                        <Card className={classes.card}>
                            <ProductCard key={product.id} product={product} showMenu={false} />
                        </Card>
                    ))}
                </Grid>
            </Grid>
            <Fab color="secondary" aria-label="Add" className={classes.fab} onClick={() => history.push('/addproduct')}>
                <AddIcon />
            </Fab>
        </div>
    );
};
