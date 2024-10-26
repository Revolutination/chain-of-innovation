import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const HeaderContainer = styled.header`
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    background-color: #282c34;
    color: white;
`;

const Logo = styled.img`
    height: 40px;
`;

const Nav = styled.nav`
    a {
        color: white;
        text-decoration: none;
        margin: 0 15px;
    }
`;

const Header = () => {
    return (
        <HeaderContainer>
            <Link to="/">
                <Logo src="/assets/logo.png" alt="Logo" />
            </Link>
            <Nav>
                <Link to="/">Home</Link>
                <Link to="/transaction">Transaction</Link>
            </Nav>
        </HeaderContainer>
    );
};

export default Header;
