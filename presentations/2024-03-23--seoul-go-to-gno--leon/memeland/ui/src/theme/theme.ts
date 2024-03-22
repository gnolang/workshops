import { defineStyle, defineStyleConfig, extendTheme } from '@chakra-ui/react';

const buttonPrimary = defineStyle({
  background: 'gno.gray',
  color: 'black',
  fontFamily: 'Fira Mono',
  fontWeight: 'bold',
  border: '2px solid black',
  borderRadius: 0,
  boxShadow: '3px 3px 0 0 rgba(0, 0, 0, 1)',

  _hover: {
    background: 'white',
    boxShadow: '2px 2px 0 0 rgba(0, 0, 0, 1)'
  },
  _disabled: {
    _hover: {
      boxShadow: 'none'
    }
  }
});

const buttonTheme = defineStyleConfig({
  variants: {
    buttonPrimary
  }
});

const theme = extendTheme({
  components: {
    Text: {
      baseStyle: () => ({
        fontWeight: 700
      })
    },
    Button: buttonTheme
  },
  styles: {
    global: () => ({
      body: {
        background:
          'linear-gradient(-45deg, #F3E8AC, #F399AF,#9EE6B4, #F6BF94, #C2B4FF)',
        backgroundSize: '400% 400%',
        animation: 'gradient 45s ease infinite',
        fontWeight: 700
      }
    })
  },
  fonts: {
    body: 'Fira Mono, sans-serif'
  },
  colors: {
    gno: {
      light: '#FFFFFF',
      dark: '#1C1C1C',
      gray: '#F1F1F1'
    }
  }
});

export default theme;
