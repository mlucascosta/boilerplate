import React from "react";
import './App.css';

class App extends React.Component {
   // Constructor 
  constructor(props) {
    super(props);
    this.state = {
      laravel: [],
      DataisLoaded: false
    };
  }

  componentDidMount() {
    fetch("http://localhost:8001/api").then(res => res.json()).then(result => this.setState({
      DataisLoaded: true,
      laravel: result
    })).catch(console.log);
  }

  render() {
        const { DataisLoaded, laravel} = this.state;
        if (!DataisLoaded) return <div className="App">
            <h1> Trying to get some data... </h1> </div>;
   
        return (
          <div className="App">
            <h1> Fetch data from Laravel in react </h1>
            <h3>{laravel}</h3>
          </div>
    );
  }
}
export default App;
