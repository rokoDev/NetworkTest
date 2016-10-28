#pragma once

#include <string>

/*!
 \file
 \brief This is config file.
 
 This is long description for config file.
 */


/*!
 *  \addtogroup SimpleNet
 *  @{
 */

//! Generic SimpleNet interfaces and implementations
namespace SimpleNet {
    //! Describes SimpleNet version
	struct Version {
		static const int Major;///major version
		static const int Minor;///minor version
		static const int Patch;///patch version
		static const int Tweak;///tweak version
		static const std::string String;///version string in format Major.Minor.Patch.Tweak
		static const std::string GIT_SHA1;///current SHA1 hash of git commit
	};
} // End namespace SimpleNet

/*! @} End of Doxygen Groups*/
