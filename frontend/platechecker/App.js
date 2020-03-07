import React, {PureComponent} from 'react';
import { View, StyleSheet } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';
import { Divider, Input, Header } from 'react-native-elements';
import { RNCamera } from 'react-native-camera';


class App extends PureComponent {
  render() {
    return (
      <View style={styles.container}>
        <Header
          centerComponent={{text: 'Plate Checker', style: {color: '#fff', fontSize: 24}}}
        />
        <Divider style={{backgroundColor: 'blue'}}/>
        <Input
          placeholder='Input license plate'
          leftIcon={
            <Icon
              name='car'
              size={24}
              color='black'
            />
          }
        />
        <RNCamera
          style={styles.preview}
          ref={ref => {
            this.camera = ref
          }}
        />
      </View>
    );
  }
}


const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
  },
  preview: {
    flex: 1,
    justifyContent: 'flex-end',
    alignItems: 'center'
  },
  capture: {
    flex: 0,
    backgroundColor: '#fff',
    borderRadius: 5,
    color: '#000',
    padding: 10,
    margin: 40
  }
});

export default App;
