import React from 'react'
import TextInput from './TextInput';
import TextArea from './TextArea';
import Email from './Email';
class Home extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            formIsValid: false,
            formControls: {

              name: {
                value: '',
                placeholder: 'What is your name',
                valid: false,
                validationRules: {
                  minLength: 4,
                  isRequired: true
                },
                touched: false
              },
              address: {
                value: '',
                placeholder: 'What is your address',
                valid: false,
                validationRules: {
                  minLength: 4,
                  isRequired: true
                },
                touched: false
              },
              email: {
                value: '',
                placeholder: 'What is your email',
                valid: false,
                validationRules: {
                  isRequired: true,
                  isEmail: true
                },
                touched: false
              },
            }
        }


    }

    changeHandler = event => {

      const name = event.target.name;
      const value = event.target.value;

      const updatedControls = {
        ...this.state.formControls
      };
      const updatedFormElement = {
        ...updatedControls[name]
      };
      updatedFormElement.value = value;
      updatedFormElement.touched = true;
      updatedFormElement.valid = validate(value, updatedFormElement.validationRules);

      updatedControls[name] = updatedFormElement;

      let formIsValid = true;
      for (let inputIdentifier in updatedControls) {
        formIsValid = updatedControls[inputIdentifier].valid && formIsValid;
      }

      this.setState({
        formControls: updatedControls,
        formIsValid: formIsValid
      });

    }

    formSubmitHandler = () => {
      const formData = {};
      for (let formElementId in this.state.formControls) {
        formData[formElementId] = this.state.formControls[formElementId].value;
      }

      console.dir(formData);
    }

    // componentDidMount() {
    //     fetch("/hello")
    //         .then(resp => {
    //             return resp.json();
    //         })
    //         .then(data => {
    //             console.log(data);
    //             this.setState(
    //                 {
    //                     ...this.state,
    //                     name: data.text,
    //                 }
    //             );
    //         })
    //         .catch(err => {
    //             console.log(err);
    //         });
    // }

    render() {
        return (
          <div>
          <TextInput name="name"
            placeholder={this.state.formControls.name.placeholder}
            value={this.state.formControls.name.value}
            onChange={this.changeHandler}
            touched={this.state.formControls.name.touched}
            valid={this.state.formControls.name.valid}
            />

            <TextArea name="address"
            placeholder={this.state.formControls.address.placeholder}
            value={this.state.formControls.address.value}
            onChange={this.changeHandler}
            touched={this.state.formControls.address.touched}
            valid={this.state.formControls.address.valid}
            />

            <Email name="my_email"
            placeholder={this.state.formControls.my_email.placeholder}
            value={this.state.formControls.my_email.value}
            onChange={this.changeHandler}
            touched={this.state.formControls.my_email.touched}
            valid={this.state.formControls.my_email.valid}
            />
            <button onClick={this.formSubmitHandler}
                disabled={! this.state.formIsValid}
            >
                Submit
                </button>
           </div>
        )
    }
}
export default Home
