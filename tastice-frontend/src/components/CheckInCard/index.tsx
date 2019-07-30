import { useMutation } from '@apollo/react-hooks';
import { Avatar, Card, CardHeader, IconButton, Link, makeStyles, Menu, MenuItem, Typography } from '@material-ui/core';
import { blue } from '@material-ui/core/colors';
import MoreVertIcon from '@material-ui/icons/MoreVert';
import { bindMenu, bindTrigger, usePopupState } from 'material-ui-popup-state/hooks';
import React, { useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import { DELETE_CHECKIN, PRODUCT } from '../../queries';
import { errorHandler, notificationHandler } from '../../utils';
import { ConfirmationDialog } from '../ConfirmationDialog';
import { ProductCard } from '../ProductCard';
import { CheckInContent } from './CheckInContent';
import { EditCheckIn } from './EditCheckIn';

const useStyles = makeStyles(theme => ({
    card: {
        maxWidth: 700,
        margin: `${theme.spacing(1)}px auto`,
    },
    media: {
        paddingTop: '56.25%',
    },
    avatar: {
        backgroundColor: blue[500],
    },
}));

const months: string[] = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
];

interface CheckInCardProps {
    checkin: CheckInObject;
    showProduct: boolean;
}

export const CheckInCard = ({ checkin, showProduct }: CheckInCardProps): JSX.Element => {
    const classes = useStyles();
    const [visible, setVisible] = useState();
    const [openEdit, setOpenEdit] = useState();
    const menuState = usePopupState({ variant: 'popover', popupId: 'CheckInMenu' });

    const authorObject = {
        id: checkin.author.id,
        firstName: checkin.author.firstName,
        lastName: checkin.author.lastName,
    };

    const checkinObject = {
        id: checkin.id,
        comment: checkin.comment,
        rating: checkin.rating,
        name: checkin.product,
        date: new Date(checkin.createdAt),
    };

    const productObject = {
        id: checkin.product.id,
        name: checkin.product.name,
        company: checkin.product.company,
        category: checkin.product.category,
        subCategory: checkin.product.subCategory,
    };

    const [deleteCheckin] = useMutation(DELETE_CHECKIN, {
        onError: errorHandler,
        refetchQueries: [{ query: PRODUCT, variables: { id: checkinObject.id } }],
    });

    const handleDeleteCheckin = async (): Promise<void> => {
        setVisible(false);
        const result = await deleteCheckin({
            variables: { id: checkinObject.id },
        });
        if (result) {
            notificationHandler({
                message: `Checkin succesfully deleted`,
                variant: 'success',
            });
        }
    };

    return (
        <>
            <Card className={classes.card}>
                <CardHeader
                    avatar={
                        <Avatar aria-label="Author" src={''} className={classes.avatar}>
                            R
                        </Avatar>
                    }
                    action={
                        <IconButton aria-label="Settings" {...bindTrigger(menuState)}>
                            <MoreVertIcon />
                        </IconButton>
                    }
                    title={
                        <Typography variant="h6" color="textSecondary" component="p">
                            <Link component={RouterLink} to={`/user/${authorObject.id}`}>
                                {authorObject.firstName} {authorObject.lastName}
                            </Link>
                        </Typography>
                    }
                    subheader={`${checkinObject.date.getDate()} ${
                        months[checkinObject.date.getMonth()]
                    }, ${checkinObject.date.getFullYear()}
          `}
                />

                {showProduct && <ProductCard product={productObject} showMenu={false} />}

                {openEdit ? (
                    <EditCheckIn id={checkinObject.id} setOpenEdit={setOpenEdit} product={productObject.name} />
                ) : (
                    <CheckInContent rating={checkinObject.rating} comment={checkinObject.comment} />
                )}
            </Card>

            <Menu {...bindMenu(menuState)}>
                <MenuItem
                    onClick={(): void => {
                        setOpenEdit(true);
                        menuState.close();
                    }}
                >
                    Edit Check-in
                </MenuItem>
                <MenuItem
                    onClick={(): void => {
                        setVisible(true);
                        menuState.close();
                    }}
                >
                    Remove Check-in
                </MenuItem>
            </Menu>

            <ConfirmationDialog
                visible={visible}
                setVisible={setVisible}
                description={'HEEII'}
                title={'Warning!'}
                content={`Are you sure you want to remove checkin for '${productObject.name}'`}
                onAccept={handleDeleteCheckin}
                declineButton={'Cancel'}
                acceptButton={'Yes'}
            />
        </>
    );
};
