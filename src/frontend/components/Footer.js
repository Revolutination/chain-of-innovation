import React from 'react';
import styled from 'styled-components';

const FooterContainer = styled.footer`
    text-align: center;
    padding: 20px;
    background-color: #282c34;
    color: white;
`;

const Footer = () => {
    return (
        <FooterContainer>
            <p>&copy; 2024 Revolutination. All rights reserved.</p>
        </FooterContainer>
    );
};

export default Footer;
