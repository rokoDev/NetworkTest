//
//  main.cpp
//  BoostUTests
//
//  Created by roko on 7/22/16.
//  Copyright © 2016 roko. All rights reserved.
//

//#define BOOST_TEST_MODULE MyLibTests
#define BOOST_TEST_DYN_LINK
#include <boost/test/unit_test.hpp>

#include <iostream>

// initialization function:
bool init_unit_test()
{
    return true;
}

// entry point:
int main(int argc, char * argv[]) {
    // insert code here...
    
    std::cout << "Boost version: "
    << BOOST_VERSION / 100000     << "."  // major version
    << BOOST_VERSION / 100 % 1000 << "."  // minor version
    << BOOST_VERSION % 100                // patch level
    << std::endl;
    
    return boost::unit_test::unit_test_main( &init_unit_test, argc, argv );
}
