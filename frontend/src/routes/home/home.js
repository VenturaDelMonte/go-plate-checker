import React from 'react'
import PlateForm from "./Form";
import { Badge } from 'reactstrap';

class Home extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
          fields: {}
        }

    }

    onChange = updatedValue => {
      this.setState({
        fields: {
          ...this.state.fields,
          ...updatedValue
        }
      });
    };


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
            <h1>Compila il modulo! <Badge color="secondary">New</Badge></h1>
            <PlateForm onChange={fields => this.onChange(fields)} />
          </div>
        )
    }
}
export default Home
